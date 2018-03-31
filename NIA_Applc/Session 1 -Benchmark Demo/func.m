

function func(F_index)

%[lb,ub,dim,fobj]=Get_Functions_details(F_index);

switch F_index 
    case 1 
        x=-100:2:100; y=x; %[-100,100]
        
     case 2
        x=-20:0.5:20; y=x;%[-20,20]
        
    case 3
        x=-200:2:200; y=x; %[-200,200]

    case 4
        x=-20:0.5:20; y=x;%[-20,20]
        
    case 5
        x=-20:0.5:20; y=x;%[-20,20]
    
end    

    


x=[100 200]
y=x;
L=length(x);
f=[];
for i=1:L
    for j=1:L
        
            f(i,j)=test_functions([x(i),y(j)],F_index);
        
       
    end
end

surfc(x,y,f,'LineStyle','none');

end

