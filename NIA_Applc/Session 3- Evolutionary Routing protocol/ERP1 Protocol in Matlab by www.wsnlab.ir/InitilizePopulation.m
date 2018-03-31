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
function [Chromosome,Fitness] = InitilizePopulation(PopulationSize,NumberOfNodes,Sensor,OptimalElectionProbability,Chromosome,Fitness)

for IndividualCounter = 1:1:PopulationSize   
    
    for SensorCounter = 1:1:NumberOfNodes 
        
        if(Sensor(SensorCounter).Energy <= 0)
            Chromosome(IndividualCounter,SensorCounter) = -1;
        else
            %Probability For a Sensor to Be a Cluster Head
            if(rand <= OptimalElectionProbability)
                Chromosome(IndividualCounter,SensorCounter) = 1;
            else
                Chromosome(IndividualCounter,SensorCounter) = 0;
            end;
        end;
 
    end;
    Fitness(IndividualCounter) = 0;
end;