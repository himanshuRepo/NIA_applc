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
function [Chromosome,Fitness] = Mutation(PopulationSize,NumberOfNodes,Chromosome,Fitness,Pm)


for IndividualCounter = 1:1:PopulationSize
    
    for SensorCounter = 1:1:NumberOfNodes
        
        if (( Chromosome(IndividualCounter,SensorCounter) ~= -1) && (rand <= Pm))
            if( Chromosome(IndividualCounter,SensorCounter) == 0)
                 Chromosome(IndividualCounter,SensorCounter) = 1;
            else
                 Chromosome(IndividualCounter,SensorCounter) = 0;
            end;    
                  
        end;  
   end;
   
end;