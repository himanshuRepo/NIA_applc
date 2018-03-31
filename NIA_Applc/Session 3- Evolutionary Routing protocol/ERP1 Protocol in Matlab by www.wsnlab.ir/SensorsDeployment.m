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
function [Sensor,Sink] = SensorsDeployment()

%Load the WSN From The Corresponding Path
%load('m=0.1\WSN_0.1\WSN1', 'Sensor');

%Creation of the random Sensor Network
figure(1);
for i=1:1:n
    Sensor(i).xd=rand(1,1)*xm;
    XR(i)=Sensor(i).xd;
    Sensor(i).yd=rand(1,1)*ym;
    YR(i)=Sensor(i).yd;
    Sensor(i).G=0;
    %initially there are no cluster heads only nodes
    Sensor(i).type='N';
   
    temp_rnd0=i;
    %Random Election of Normal Nodes
    if (temp_rnd0>=m*n+1) 
        Sensor(i).E=Eo;
        Sensor(i).ENERGY=0;
        plot(Sensor(i).xd,Sensor(i).yd,'o');
        hold on;
    end
    %Random Election of Advanced Nodes
    if (temp_rnd0<m*n+1)  
        Sensor(i).E=Eo*(1+a)
        Sensor(i).ENERGY=1;
        plot(Sensor(i).xd,Sensor(i).yd,'+');
        hold on;
    end
end    
        





Sink.X = 50;
Sink.Y = 50;