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

function [Sensor, STATISTICS,IsCluster, C, X, Y] = ClusterHeadElection(PopulationSize,MaxIteration,Pc,Pm,Sensor, Sink, ...
                                                        STATISTICS,StatisticCounter,IsCluster, ...
                                                        C, X, Y, ...
                                                        NumberOfNodes, ...
                                                        OptimalElectionProbability, ...
                                                        ETX, ERX, Efs, Emp, EDA, do)
                                                  
%Initilizing Population Seeds 
Chromosome = zeros(20,100);
Fitness = zeros(1,20);

%Initilize population
[Chromosome,Fitness] = InitilizePopulation(PopulationSize,NumberOfNodes,Sensor,OptimalElectionProbability,Chromosome,Fitness);

%Fitness Evaluation
[Chromosome,Fitness] = CalculateFitness(PopulationSize,NumberOfNodes,Chromosome,Fitness,Sensor);

for IterationCounter = 1:1:MaxIteration
    %Selection
    [Chromosome,Fitness] = Selection(PopulationSize,NumberOfNodes,Chromosome,Fitness);
    %Crossover
    [Chromosome,Fitness] = Crossover(PopulationSize,Pc,NumberOfNodes,Chromosome,Fitness);
    %Mutation
    [Chromosome,Fitness] = Mutation(PopulationSize,NumberOfNodes,Chromosome,Fitness,Pm);
    %Fitness Evaluating
    [Chromosome,Fitness] = CalculateFitness(PopulationSize,NumberOfNodes,Chromosome,Fitness,Sensor);    
end;

MinFitnessIndividual = 1;
MinFitness=Fitness(MinFitnessIndividual);

%Finding The Best Indivitual With Minimum Fitness (Minimization)
for IndividualCounter = 1:1:PopulationSize
    if(Fitness(IndividualCounter) < MinFitness)
        MinFitnessIndividual = IndividualCounter;
        MinFitness = Fitness(IndividualCounter);
    end;
end;

%Actual Ellection of CHs
countCHs = 0;
countNCHs = 0;
countACHs = 0; 

for SensorCounter = 1:1:NumberOfNodes
     if((Chromosome(MinFitnessIndividual,SensorCounter) == 1))
         countCHs = countCHs + 1;
         STATISTICS(StatisticCounter).PACKETS_TO_BS = STATISTICS(StatisticCounter).PACKETS_TO_BS + 1;
         Sensor(SensorCounter).Type = 'C';
         C(countCHs).X = Sensor(SensorCounter).X;
         C(countCHs).Y = Sensor(SensorCounter).Y;
         C(countCHs).Distance = sqrt( (Sensor(SensorCounter).X - Sink.X )^2 + (Sensor(SensorCounter).Y - Sink.Y )^2 );
         C(countCHs).ID = SensorCounter;
         plot(Sensor(SensorCounter).X, Sensor(SensorCounter).Y, '*b') % draw a cluster-head
         hold on;
         
         X(countCHs) = Sensor(SensorCounter).X;
         Y(countCHs) = Sensor(SensorCounter).Y;
         
         if(Sensor(SensorCounter).EnergyType == 0)
             countNCHs = countNCHs + 1;
         else
             countACHs = countACHs + 1;
         end;
                  
         %Calculation of Energy dissipated (CH->BS)
         if (C(countCHs).Distance > do)
                Sensor(SensorCounter).Energy = Sensor(SensorCounter).Energy - ((ETX+EDA)*(4000) + Emp*4000*( C(countCHs).Distance^4)); 
                STATISTICS(StatisticCounter).DissipationEnergy = STATISTICS(StatisticCounter).DissipationEnergy+((ETX+EDA)*(4000) + Emp*4000*( C(countCHs).Distance^4 ));
         else
                Sensor(SensorCounter).Energy = Sensor(SensorCounter).Energy - ((ETX+EDA)*(4000)  + Efs*4000*( C(countCHs).Distance^2 )); 
                 STATISTICS(StatisticCounter).DissipationEnergy = STATISTICS(StatisticCounter).DissipationEnergy + ((ETX+EDA)*(4000)  + Efs*4000*( C(countCHs).Distance^2 ));
         end;
         
     end;
 end;
 
STATISTICS(StatisticCounter).ClusterHeads = countCHs;
STATISTICS(StatisticCounter).NormalClusterHeads = countNCHs;
STATISTICS(StatisticCounter).AdvancedClusterHeads = countACHs;

if(countCHs > 0)
    IsCluster = 1;
end;


