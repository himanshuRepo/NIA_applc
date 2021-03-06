%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA101
% Project Title: Implementation of Binary Genetic Algorithm in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function y=Mutate(x,mu)

    nVar=numel(x);
    
    nmu=ceil(mu*nVar);
    
%    j=randsample(nVar,nmu);
    j=randi(nVar);
    y=x;
    %inversion of gene
    y(j)=1-x(j);

end