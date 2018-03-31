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
function [Eo, ETX, ERX, Efs, Emp, EDA, do] = InitializeEnergyModel()

%Energy Model (all values in Joules)
%Initial Energy 
Eo = 0.0001;

%Eelec=Etx=Erx
ETX = 50 * 0.000000001;
ERX = 50 * 0.000000001;

%Transmit Amplifier types
Efs = 10 * 0.000000000001;
Emp = 0.0013 * 0.000000000001;

%Data Aggregation Energy
EDA = 5 * 0.000000001;

%Computation of do % short distance
do = sqrt(Efs / Emp);