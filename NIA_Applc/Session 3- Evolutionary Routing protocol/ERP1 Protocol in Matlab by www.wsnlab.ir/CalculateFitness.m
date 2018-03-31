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
function [Chromosome,Fitness]=CalculateFitness(PopulationSize,NumberOfNodes,Chromosome,Fitness,Sensor)

for IndividualCounter = 1:1:PopulationSize
    
    %Obtaining Number of CHs
    CHcount = 0;
    for SensorCounter = 1:1:NumberOfNodes 
        if(Chromosome(IndividualCounter,SensorCounter) == 1)
            CHcount = CHcount + 1;
            TempCH(CHcount).X = Sensor(SensorCounter).X;
            TempCH(CHcount).Y = Sensor(SensorCounter).Y;
        end;
    end;
    
    %Obtaining J2 (Compactness)
    Compactness = 0;
    for SensorCounter = 1:1:NumberOfNodes
        if(Chromosome(IndividualCounter,SensorCounter) == 0)
            
            MinDistance = 100000000;
            ClusterOfMinDistance = 0;
            for TempCHCount = 1:1:CHcount
                temp = sqrt((Sensor(SensorCounter).X - TempCH(TempCHCount).X)^2 + (Sensor(SensorCounter).Y - TempCH(TempCHCount).Y)^2 );
                if (temp < MinDistance)
                MinDistance = temp;
                ClusterOfMinDistance = TempCHCount;
                end;    
            end;    
            Compactness = Compactness + MinDistance;    
        end;     
    end;
    
    %Separation error obtaining
    TempCHDistanceCounter = 1;
    if (CHcount <= 1)
        Separation = 1;
    else
        for i = 1:1:CHcount - 1
            for j = i + 1:1:CHcount
                TempCHDistance(TempCHDistanceCounter) = sqrt((TempCH(i).X - TempCH(j).X)^2 + (TempCH(i).Y - TempCH(j).Y)^2 );
                TempCHDistanceCounter = TempCHDistanceCounter + 1;
            end;
        end;
       Separation = min(TempCHDistance);
    end;
    
    %Fitness Calculation
    Fitness(IndividualCounter) = Compactness / Separation + CHcount;
       
end;