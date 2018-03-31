function z=Rosenbrock(x)

	dim = size(x,2);
    z=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
end