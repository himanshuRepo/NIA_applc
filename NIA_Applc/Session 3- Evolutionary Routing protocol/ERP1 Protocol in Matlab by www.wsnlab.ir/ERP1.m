%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%                 An Evolutionary Routing Protocol for                 %
%                Dynamic Clustering of Wireless Sensor                 %
%                               Networks                               %
%                                                                      %
%                     By: Mohammad Hossein Homaei                      %
%                           homaei@wsnlab.ir                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
%                 Evolutionary Routing Protocol-1 (ERP1)               %  
%                                                                      %
%                     By: Mohammad Hossein Homaei                      %
%                           homaei@wsnlab.ir                           %
%                             www.wsnlab.ir                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
function [STATISTICS]=ERP1()

clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%   STEP ONE      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%INITIALIZE PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Initialize parameters of WSN field:                               %
%    XMax, YMax: Field Dimensions (in meters or any units)             %
%    Sink: X and Y coordinates of the Sink                             %
%    NumberOfNodes: Number of Nodes in the field                       %
%    OptimalElectionProbability: Optimal Election Probability of a     %
%    node to become cluster head                                       %
%    RMax: maximum number of rounds                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[XMax, YMax, NumberOfNodes,OptimalElectionProbability,RoundMax] = InitializeWSN();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Initialize WSN to be heterogeneous:                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[AdvancedNodesPercentage, Alpha] = InitializeHeterogeneous();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Initialize Radio Energy Dissipation Model (Radio communication model):   %
%     Eo: Initial Energy of each normal sensor                                %
%     ETX: Energy dissepated by the radio circuit to transmit one bit         %
%     ERX: Energy dissepated by the radio circuit to receive one bit          %
%          Note that ETX and ERX is set equal to Eelec: the energy dissepated % 
%          per bit to run the transmitter or the receiver circuit.            %
%     Efs and Emp depends on the transmitter amplifier model                  %
%     EDA: processing (data aggregation) cost of a bit per report to the sink % 
%     do: distance initial                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Eo, ETX, ERX, Efs, Emp, EDA, do] = InitializeEnergyModel();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% END OF INITIALIZE PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Our program maintain two main data structures: Sensor data structure and     %
% STATISTICS data structure.                                                   %
% 1. Sensor is a vector of length NumberOfNodes,                               %
% each record of it consists of six fields named: X,Y,G,Type,Energy, and       %
% EnergyType. X and Y act as coordinators of the corresponding sensor          %
% record. G is a boolean specifying whether the corresponding sensor           %
% belongs to list G '1' or not '0'. Type determines whether the corresponding  %
% sensor is selected as Cluster-head 'C' or not 'N' at the current round.      %
% Energy holds the current (i.e. remaining) energy of the corresponding        %
% sensor. Finally, EnergyType is a boolean specifying whether the sensor is    %
% of advanced '1' or normal '0' type.                                          %
% 2. STATISTICS is a vector of length RoundMax, i.e. each round of the         %
% algorithm holds statistics stored in the corresponding record of             %
% STATISTICS. Each record contains Ten fields:DeadNodes, DeadAdvancedNodes,    %
% DeadNormalNodes, PACKETS_TO_CH, PACKETS_TO_BS,ClusterHeads,                  %
% NormalClusterHeads,AdvancedClusterHeads,DissipationEnergy and                %
% RemainingEnergy.Total number of dead nodes,                                  %
% dead advanced nodes, and dead normal nodes are accumulated in each round.    %
% Moreover, total number of packets (bit) transmitted from non cluster heads to%
% cluster heads nodes and total number of packets transmitted from cluster     %
% heads to the sink are also accumulated. total number of                      %
% cluster-heads,Number of Normal and Advanced  nodes elected ClusterHeads in   %
%the each round is also saved. Additionally,total Dissipated Energy and        %
% total Remaining Energy of all nodes are also obtained for each round.        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%   STEP TWO      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%     Creation of the random Sensor Network     %%%%%%%%%%%%%%%

% i.e. Deployment of sensors (normal, advanced, & sink) in the field

[Sensor,Sink] = SensorsDeployment();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%   END OF SENSORS DEPLOYEMENT  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%   STEP Three      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%    Initilize Evolutionary Algorithm Parameters     %%%%%%%%%%%%%%%%%

[PopulationSize,MaxIteration,Pc,Pm] = InitilizeEA();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%   END OFEvolutionary Algorithm initialization  %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%First Iteration

STATISTICS = [];
C = [];
X = [];
Y = [];

first_dead = -1;
Last_dead = -1;
flag_first_dead = 0;

StatisticCounter = 1;

RoundCounter = 0;
NetworkAlive = true;

%%%%%%%%%%%%%%%%%%%%%%%    STEP FOUR    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   Rounds of ERP-1   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while((RoundCounter <= RoundMax && NetworkAlive))
    
    RoundCounter
    
    figure(1);
    hold off;
    
    [STATISTICS, Sensor] = GetStatisticsOfWSN(Sensor, Sink, NumberOfNodes, ...
                                              STATISTICS,StatisticCounter, ...
                                              RoundCounter);
    
    %When the first node dies
    if (STATISTICS(StatisticCounter).DeadNodes >= 1)
        if(flag_first_dead == 0)
            first_dead = StatisticCounter; %  first_dead: the round where the first node died                   
            flag_first_dead = 1;
        end;
    end;
    
    
    if(STATISTICS(StatisticCounter).DeadNodes > 0)
            if(STATISTICS(StatisticCounter).DeadNodes == NumberOfNodes)
                  Last_dead = StatisticCounter; %  Last_dead: the round where the Last node died                   
                  NetworkAlive = false; %If all Nodes Died
            end;
    end;
        
    IsCluster = 0;  
    
    %Cluster-Head Election Phase
    [Sensor, STATISTICS,IsCluster,C, X, Y] = ClusterHeadElection(PopulationSize,MaxIteration,Pc,Pm,Sensor, Sink, ...
                                                        STATISTICS,StatisticCounter,IsCluster, ...
                                                        C, X, Y,...
                                                        NumberOfNodes, ...
                                                        OptimalElectionProbability, ...
                                                        ETX, ERX, Efs, Emp, EDA, do);
                                                    
    
    %Election of Associated Cluster Head for Normal Nodes %i.e. Connection
    %Establishment and Data Transmission phases (steady state phase)  
    if(IsCluster == 1)
        [Sensor, STATISTICS] = ClusterHeadAssociation(Sensor, Sink, ...
                                                  STATISTICS, ...
                                                  StatisticCounter, ...
                                                  NumberOfNodes, ...
                                                  ETX, ERX, Efs, Emp, EDA, do, ...
                                                  C);
         for SensorCounter = 1:NumberOfNodes
             %Caliculation of Total Remaining Energy
             STATISTICS(StatisticCounter).RemainingEnergy = STATISTICS(StatisticCounter).RemainingEnergy+Sensor(SensorCounter).Energy;
         end;
    
    end;
    
    hold on;
    %DrawVoronoiCell(X,Y, XMax, YMax);

    if(IsCluster == 1) 
        StatisticCounter = StatisticCounter+1;
    end 
    RoundCounter = RoundCounter + 1; 
end;
%save('m=0.2\Statistics_0.2\STATISTIC_WSN15.mat','STATISTICS');
%save('m=0.2\Statistics_0.2\FirsetDead_LastDead_WSN15.mat','first_dead','Last_dead');
first_dead
len=length(STATISTICS);
len
Last_dead
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
