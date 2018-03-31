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
function [XMax, YMax, NumberOfNodes, OptimalElectionProbability, RoundMax] = InitializeWSN()

%Field Dimensions - X and Y maximum (in meters)
YMax = 100;
XMax = 100;

%Number of Nodes in the field
NumberOfNodes = 100;

%The optimal number of constructed clusters
Kopt = sqrt(NumberOfNodes / (2 * pi))*(2 / 0.765);

%Optimal Election Probability of a node to become cluster head
OptimalElectionProbability = (Kopt / NumberOfNodes);

%maximum number of rounds
RoundMax = input('Input Nomber of Rounds   ');