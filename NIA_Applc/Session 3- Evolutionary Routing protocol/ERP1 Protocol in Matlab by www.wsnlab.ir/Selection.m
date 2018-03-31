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
function [Chromosome,Fitness] = Selection(PopulationSize,NumberOfNodes,Chromosome,Fitness)

TempChromosome = zeros(20,100);
TempFitness = zeros(1,20);

for IndividualCounter = 1:1:PopulationSize 
    
    %Generating Random Nomber Between 1 and 20
    temp1 = round(rand *(PopulationSize - 1)+ 1);
    temp2 = round(rand *(PopulationSize - 1)+ 1);
    
    %Using turnment Selection to Select the Indivitual With Minimum Fitness
    if(Fitness(temp1) < Fitness(temp2))
        for i = 1:1:NumberOfNodes
             TempChromosome(IndividualCounter,i) = Chromosome(temp1,i);
             TempFitness(IndividualCounter) = Fitness(IndividualCounter);
        end;
        TempFitness(IndividualCounter) = Fitness(temp1);   
    else
        for i = 1:1:NumberOfNodes
             TempChromosome(IndividualCounter,i) = Chromosome(temp2,i);
             TempFitness(IndividualCounter) = Fitness(IndividualCounter);
        end;
        TempFitness(IndividualCounter) = Fitness(temp2);
    end;   
end;

Chromosome = zeros(20,100);
Fitness = zeros(1,20);

for IndividualCounter = 1:1:PopulationSize       
    for SensorCounter = 1:1:NumberOfNodes 
        Chromosome(IndividualCounter,SensorCounter) = TempChromosome(IndividualCounter,SensorCounter);
    end;
     Fitness(IndividualCounter) = TempFitness(IndividualCounter);
end;