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
function [Sensor, STATISTICS] = ClusterHeadAssociation(Sensor, Sink, ...
                                                  STATISTICS, ...
                                                  StatisticCounter, ...
                                                  NumberOfNodes, ...
                                                  ETX, ERX, Efs, Emp, EDA, do, ...
                                                  C)
                                              
for SensorCounter = 1:NumberOfNodes
    if (Sensor(SensorCounter).Type == 'N' && Sensor(SensorCounter).Energy > 0 && (STATISTICS(StatisticCounter).ClusterHeads) >= 1)
        MinDistance = sqrt( (Sensor(SensorCounter).X -  C(1).X)^2 + (Sensor(SensorCounter).Y -  C(1).Y)^2 );
        ClusterOfMinDistance = 1;
        for ClusterCounter = 2:STATISTICS(StatisticCounter).ClusterHeads
            Temp = min(MinDistance, sqrt((Sensor(SensorCounter).X - C(ClusterCounter).X)^2 + (Sensor(SensorCounter).Y - C(ClusterCounter).Y)^2 ));
            if (Temp < MinDistance)
                MinDistance = Temp;
                ClusterOfMinDistance = ClusterCounter;
            end;
        end;
        %Energy dissipated by the sensor to transmit a packet to associated Cluster Head(node -> CH )
        if (MinDistance > do)
                Sensor(SensorCounter).Energy = Sensor(SensorCounter).Energy - ( ETX*(4000) + Emp*4000*( MinDistance^4)); 
                STATISTICS(StatisticCounter).DissipationEnergy=STATISTICS(StatisticCounter).DissipationEnergy+( ETX*(4000) + Emp*4000*( MinDistance^4));
        
        else % (MinDistance <= do)
                Sensor(SensorCounter).Energy = Sensor(SensorCounter).Energy- ( ETX*(4000) + Efs*4000*( MinDistance^2)); 
                STATISTICS(StatisticCounter).DissipationEnergy=STATISTICS(StatisticCounter).DissipationEnergy+( ETX*(4000) + Efs*4000*( MinDistance^2));
        end;
        %Energy dissipated by cluster head to receive a packet (CH <- )
        if(MinDistance > 0)
           Sensor(C(ClusterOfMinDistance).ID).Energy = Sensor(C(ClusterOfMinDistance).ID).Energy - ( (ERX + EDA)*4000 );
           STATISTICS(StatisticCounter).DissipationEnergy = STATISTICS(StatisticCounter).DissipationEnergy +( (ERX+EDA)*4000 );        
        end;

        Sensor(SensorCounter).MinDistance = MinDistance;
        Sensor(SensorCounter).ClusterOfMinDistance = ClusterOfMinDistance;
    end;
end;
STATISTICS(StatisticCounter).PACKETS_TO_CH = NumberOfNodes - STATISTICS(StatisticCounter).DeadNodes - STATISTICS(StatisticCounter).ClusterHeads;% why:+1; %n-dead-cluster+1; 
                                              
                                              
