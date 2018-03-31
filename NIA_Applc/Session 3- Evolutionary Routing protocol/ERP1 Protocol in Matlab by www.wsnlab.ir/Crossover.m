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
function [Chromosome,Fitness] = Crossover(PopulationSize,Pc,NumberOfNodes,Chromosome,Fitness)

for IndividualCounter = 1:2:PopulationSize
    
    %Checking Crossover Probability
    if(rand <= Pc)
        %Generating Tow Random Cut Points
        cp1 = round(rand *(NumberOfNodes - 2) + 1);
        cp2 = round(rand *(NumberOfNodes - 2) + 1);
        
       if(cp1 > cp2)
           t = cp1;
           cp1 = cp2;
           cp2 = t;
       end;
       
        %Recombination
        for SensorCounter = cp1:1:cp2
            if( Chromosome(IndividualCounter,SensorCounter) ~= -1)
                 temp = Chromosome(IndividualCounter,SensorCounter);
                 Chromosome(IndividualCounter,SensorCounter) = Chromosome(IndividualCounter + 1,SensorCounter);
                 Chromosome(IndividualCounter + 1,SensorCounter) = temp;
            end;
            
        end; 
    end;
end;