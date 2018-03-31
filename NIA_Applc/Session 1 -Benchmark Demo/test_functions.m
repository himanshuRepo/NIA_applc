function fit=test_functions(L,F_index)

%Insert your own objective function with a new F_index.

dim = size(L,2);

if F_index==1 %Ackley
    fit=-20*exp(-.2*sqrt(sum(L.^2)/dim))-exp(sum(cos(2*pi.*L))/dim)+20+exp(1);
end

if F_index==2 %Apline
    fit=sum(abs(L.*sin(L)+0.1.*L));
end

if F_index==3 % Sphere
fit=sum(L.^2);
end

if F_index==4 % Rosenbrock
    fit=sum(100*(L(2:dim)-(L(1:dim-1).^2)).^2+(L(1:dim-1)-1).^2);
end

if F_index==5 % Booth
fit=(L(1)+2*L(2)-7)^2+(2*L(1)+L(2)-5)^2;
end





return