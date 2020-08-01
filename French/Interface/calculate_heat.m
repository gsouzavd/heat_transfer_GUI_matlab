function [balanco, cont] = calculate_heat(data)

%% Entry Data of the function
% Dimensions of the evaluated function
L=data.length;
W=data.width;

% Launch conditions of the problem
m=data.divisions;
dx=W/(m-1);
n=L/W*(m-1)+1;
tol=10^-7;
erromax=1;
cont=0;

% m -> Number of lines
% n -> Number of colluns

Ta=30+zeros(m,n);
T=zeros(m,n);
% Distribution of the walls
%            1
%   ____________________
%  |                    |
%4 |                    |2
%  |                    |
%  |____________________|
%            3

% Border conditions 
% Caracteristics of the material and from the ambient
k=data.conduction;
qp=data.geration;

% Error handling
% Prevent nevative temperatures
if (data.Temp_Presc_1<0)
    data.Temp_Presc_1 = 0;
end
if (data.Temp_Presc_2<0)
    data.Temp_Presc_2 = 0;
end
if (data.Temp_Presc_3<0)
    data.Temp_Presc_3 = 0;
end
if (data.Temp_Presc_4<0)
    data.Temp_Presc_4 = 0;
end
if (data.Temp_Amb_1<0)
    data.Temp_Amb_1 = 0;
end
if (data.Temp_Amb_1<0)
    data.Temp_Amb_1 = 0;
end
if (data.Temp_Amb_2<0)
    data.Temp_Amb_2 = 0;
end
if (data.Temp_Amb_3<0)
    data.Temp_Amb_3 = 0;
end
if (data.Temp_Amb_4<0)
    data.Temp_Amb_4 = 0;
end

% First wall
if (data.state_1 == 1)
    T1= data.Temp_Presc_1; h1=0; Tinf1=0; q2l_1=0; 
else
    T1= 0; h1= data.Conv_1; Tinf1= data.Temp_Amb_1; q2l_1= data.Flux_1; 
end

% Second wall
if (data.state_2 == 1)
    T2= data.Temp_Presc_2; h2= 0; Tinf2= 0; q2l_2= 0;  
else
    T2=0; h2= data.Conv_2; Tinf2= data.Temp_Amb_2; q2l_2= data.Flux_2;  
end

% Third wall
if (data.state_3 == 1)
    T3= data.Temp_Presc_3; h3= 0; Tinf3= 0; q2l_3= 0;  
else
    T3=0; h3= data.Conv_3; Tinf3= data.Temp_Amb_3; q2l_3= data.Flux_3;   
end

% Fourty wall
if (data.state_4 == 1)
    T4= data.Temp_Presc_4; h4= 0; Tinf4= 0; q2l_4= 0; 
else
    T4= 0; h4= data.Conv_4; Tinf4= data.Temp_Amb_4; q2l_4= data.Flux_4; 
end


%% Numeric solution
while erromax>=tol
    cont=cont+1;
    
    for j=1:n
        for i=1:m
           % Wall
            if (i==1 && j>1 && j<n) %1
                if (data.state_1 == 1) % If it's an adiabatic wall
                    Ta(i,j) = T1;
                else
                    Ta(i,j)=(0.5*T(i,j+1)+0.5*T(i,j-1)+T(i+1,j)+(h1*Tinf1+q2l_1)*dx/k + qp*dx^2/(2*k))/(2+h1*dx/k);
                end
            elseif (i==m && j>1 && j<n) %3
                if (data.state_3 == 1)
                    Ta(i,j) = T3;
                else
                    Ta(i,j)=(0.5*T(i,j+1)+0.5*T(i,j-1)+T(i-1,j)+(h3*Tinf3+q2l_3)*dx/k + qp*dx^2/(2*k))/(2+h3*dx/k);
                end
             elseif (j==1 && i>1 && i<m)%4
                if (data.state_4 == 1)
                    Ta(i,j)= T4;
                else
                    Ta(i,j)=(0.5*T(i-1,j)+0.5*T(i+1,j)+T(i,j+1)+(h4*Tinf4+q2l_4)*dx/k + qp*dx^2/(2*k))/(2+h4*dx/k);
                end
            elseif (j==n && i>1 && i<m)%2
                if (data.state_2 == 1)
                    Ta(i,j) = T2;
                else
                    Ta(i,j)= (0.5*T(i-1,j)+0.5*T(i+1,j)+T(i,j-1)+(h2*Tinf2+q2l_2)*dx/k + qp*dx^2/(2*k))/(2+h2*dx/k);
                end
            %quinas
            elseif (i==1 && j==1)
                if (data.state_1 == 1 && data.state_4 == 1)
                    Ta(i,j) = (T1+T4)/2;
                elseif (data.state_1 == 1)
                    Ta(i,j) = T1;
                elseif (data.state_4 == 1)
                    Ta(i,j)=T4;
                else
                    Ta(i,j)=(T(i,j+1)+T(i+1,j)+(h1*Tinf1+q2l_1)*dx/k +(h4*Tinf4+q2l_4)*dx/k + qp*dx^2/(2*k))/ (2+h1*dx/k+h4*dx/k);
                end
            elseif(i==1 && j==n)
                if (data.state_1 == 1 && data.state_2 == 1)
                    Ta(i,j) = (T1+T2)/2;
                elseif (data.state_1 == 1)
                    Ta(i,j) = T1;
                elseif (data.state_2 == 1)
                    Ta(i,j) = T2;
                else
                    Ta(i,j)=(T(i+1,j)+T(i,j-1)+(h1*Tinf1+q2l_1)*dx/k +(h2*Tinf2+q2l_2)*dx/k + qp*dx^2/(2*k))/(2+h1*dx/k+h2*dx/k);  
                end
            elseif (i==m && j==1)
                if (data.state_4 == 1 && data.state_3 == 1)
                   Ta(i,j) = (T3+T4)/2;
                elseif (data.state_3 == 1)
                    Ta(i,j) = T3;
                elseif (data.state_4 == 1)
                    Ta(i,j)=T4;
                else
                    Ta(i,j)=(T(i,j+1)+T(i-1,j)+(h3*Tinf3+q2l_3)*dx/k +(h4*Tinf4+q2l_4)*dx/k + qp*dx^2/(2*k))/(2+h3*dx/k+h4*dx/k); 
                end
            elseif (i==m && j==n)
                if (data.state_2 == 1 && data.state_3 == 1)
                    Ta(i,j) = (T2+T3)/2;
                elseif (data.state_2 == 1)
                    Ta(i,j) = T2;
                elseif (data.state_3 == 1)
                    Ta(i,j) = T3;
                else
                    Ta(i,j)=(T(i-1,j)+T(i,j-1)+(h2*Tinf2+q2l_2)*dx/k +(h3*Tinf3+q2l_3)*dx/k + qp*dx^2/(2*k))/(2+h2*dx/k+h3*dx/k);
                end            
            %nós interiores
            else
                Ta(i,j)=(T(i+1,j)+T(i-1,j)+T(i,j+1)+T(i,j-1)+qp*dx^2/k)/4;
            end
        
        end
    end

    
    erro= abs(T-Ta);
    T=Ta;
         
    
    erromax=max(max(erro));

end

%% Balance

fluxo1=q2l_1*L;
fluxo2=q2l_2*W;
fluxo3=q2l_3*L;
fluxo4=q2l_4*W;

ger=qp*(L*W);


%% Balance for the first wall

% Check if T is given in both corners
cond1 = 0;
if (data.state_1 == 1 && data.state_2 ~= 1) %Checa se existe T prescrita e convecção
    cond1=cond1 + k*dx/2*(T(1,n)-T(2,n))/dx;
end
if (data.state_1 == 1 && data.state_4 ~= 1)
    cond1=cond1 + k*dx/2*(T(1,1)-T(2,1))/dx;
end

% Check if T is Given in the wall
if (data.state_1 == 1)
    for j=2:n-1
         cond1=cond1+k*dx*(T(1,j)-T(2,j))/dx;
    end
    conv1 = 0;
else
    conv1 = 0;
    if (data.state_2 ~= 1) % Convection in the superior conner
        conv1 = conv1 + h1*dx/2*(Tinf1-T(1,n));
    end
    if (data.state_4 ~= 1) % Convection in the lower conner
        conv1 = conv1 + h1*dx/2*(Tinf1-T(1,1));
    end
    if (data.state_2 == 1 && data.state_4 == 1)
        conv1 = 0; % No convection in both conners
    end
    for j=2:n-1 % Convection in the wall
         conv1=conv1+h1*dx*(Tinf1-T(1,j));
    end
    cond1 = 0;
end

%% Balance for the second wall


% Check if T is given in both corners
cond2 = 0;
if (data.state_2 == 1 && data.state_1 ~= 1)
    cond2= cond2 + k*dx/2*(T(1,n)-T(1,n-1))/dx;
end
if (data.state_2 == 1 && data.state_3 ~= 1)
    cond2= cond2 + k*dx/2*(T(m,n)-T(m,n-1))/dx;
end

% Checks if T is given
if (data.state_2 == 1)
    for i=2:m-1
         cond2=cond2+k*dx*(T(i,n)-T(i,n-1))/dx;
    end
    conv2 = 0;
else
    conv2 = 0;
    if (data.state_1 ~= 1) 
        conv2= conv2 + h2*dx/2*(Tinf2-T(1,n));
    end
    if (data.state_3 ~= 1)
        conv2 = conv2 + h2*dx/2*(Tinf2-T(m,n));
    end
    if (data.state_1 == 1 && data.state_3 == 1)
        conv2 = 0;
    end
    for i=2:m-1
         conv2=conv2+h2*dx*(Tinf2-T(i,n));
    end
    cond2 = 0;
end

%% Balance for third wall

% Check if T is given in both corners
cond3 = 0;
if (data.state_3 == 1 && data.state_2 ~= 1)
    cond3=cond3 + k*dx/2*(T(m,n)-T(m-1,n))/dx;
end
if (data.state_3 == 1 && data.state_4 ~= 1)
    cond3=cond3 + k*dx/2*(T(m,1)-T(m-1,1))/dx;
end

% Checks if T is given
if (data.state_3 == 1)
    for j=2:n-1
         cond3=cond3+k*dx*(T(m,j)-T(m-1,j))/dx;
    end
    conv3 = 0;
else
    conv3 = 0;
    if (data.state_4 ~= 1)
        conv3 = conv3 + h3*dx/2*(Tinf3-T(m,1));
    end
    if (data.state_2 ~= 1)
        conv3 = conv3 + h3*dx/2*(Tinf3-T(m,n));
    end
    if (data.state_4 == 1 && data.state_2 == 1)
        conv3 = 0;
    end
    for j=2:n-1
         conv3=conv3+h3*dx*(Tinf3-T(m,j));
    end
    cond3 = 0;
end

%% Balance in the fourth wall


% Check if T is given in both corners
cond4 = 0;
if (data.state_4 == 1 && data.state_1 ~= 1)
    cond4=cond4+k*dx/2*(T(1,1)-T(1,2))/dx;
end
if (data.state_4 == 1 && data.state_3 ~= 1)
    cond4=cond4+k*dx/2*(T(m,1)-T(m,2))/dx;
end

% Checks if T is given
if (data.state_4 == 1)
    for i=2:m-1
         cond4=cond4+k*dx*(T(i,1)-T(i,2))/dx;
    end
    conv4 = 0;
else
    conv4 = 0;
    if (data.state_1 ~= 1) 
        conv4=conv4 + h4*dx/2*(Tinf4-T(1,1));
    end
    if (data.state_3 ~= 1)
        conv4 =conv4 +  h4*dx/2*(Tinf4-T(m,1));
    end
    if (data.state_1 == 1 && data.state_3 == 1)
        conv4 = 0;
    end
    for i=2:m-1
         conv4=conv4+h4*dx*(Tinf4-T(i,1));
    end
    cond4 = 0;
end

%% Bilan final

balanco=fluxo1+fluxo2+fluxo3+fluxo4+conv1+conv2+conv3+conv4+ger+cond1+cond2+cond3+cond4;

%% Plots

x=[0:dx:L];
y=[0:dx:W];

fig = figure('visible','off');
contourf(x,y,T)
set(gca,'ydir',' reverse')
colorbar

title('Temperature')
xlabel('Position en x [m]')
ylabel('Position en y [m]')

saveas(fig,'Result.png')

end