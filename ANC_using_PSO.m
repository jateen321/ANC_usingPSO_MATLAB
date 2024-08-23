clc
close all
clear all

% N=input('length of sequence N = ');
N = 100;
t=[0:N-1];
w0=0.1;  phi=0.1;
d=sin(2*pi*[1:N]*w0+phi);% desired signal
x=d+randn(1,N)*0.5; %input signal
% SysOrder = input('Input the filter Length(system Order)');
SysOrder = 10;


%% parameters%%
Max_iter = 1000; % Maximum Number of Iterations
inertia = 0.3; %Ineritia coefficient
c_1 = 2; %cognitive constant
c_2 = 2;%social constant
swarm_size  = 10; %swarm size
Min = -5.12;
Max = 5.12;

%% giving intial position and velocity  to zero and best_fitness value to 1000.
swarm = zeros(swarm_size,4,SysOrder);
for i=  1:swarm_size 
    for j = 1: SysOrder
        swarm(i,1,j)  = Max - rand * (Max -Min) ;
        swarm(i,2,j)  = 0 ;
    end
end

for i = 1:swarm_size
    swarm(i ,4) = 1000;
end
%% Loop starts
for  iter = 1 : Max_iter
    for i = 1 : swarm_size
      for j = 1: SysOrder
        swarm(i ,1,j)  =  swarm(i ,1,j) + swarm(i ,2,j);% updating the position of particle x-dimension
        position(j) = [swarm(i , 1,j)]; % particle position in form of matrix
      end
      fval =  ANC(position ,x,d,N,SysOrder);

      if fval < swarm(i,4) %if fitness value  is better than best -fitness of particle then
        for j = 1 : SysOrder
         swarm(i,3,j)  = swarm(i ,1,j); %change both values First Dimension of best fitness vector
        end
        swarm(i ,4) = fval; %update the best fitness value of the particle
      end
      

    end
    [target , gbest] = min(swarm(:,4)); %gbest will store the i th value of the particle in which gbest value is found
    for i = 1 :swarm_size 
        for j  = 1 : SysOrder
            swarm(i,2,j) = inertia * swarm(i,2,j)  + c_1 * rand * (swarm(i,3,j) - swarm(i,1,j)) +  c_2 * rand * (swarm(gbest,3,j) - swarm(i,1,j));
        end
    end
end  

function [y] = ANC(weights , x, d, N ,filtLgth)
   filterSignal = zeros(1,N);
   for i = filtLgth : N 
     vectorSignal =  x(i - filtLgth +1 : i)';
     filterSignal(i) = ( weights * vectorSignal);
   end
   error(filtLgth : N) = d(filtLgth : N) - filterSignal(filtLgth : N);
   y = sum(error .^2);

end

function [filterSignal] = SglWithWghts(weights , x,N,filtLgth)
    filterSignal  = zeros(1,N);
    for i = filtLgth : N
       vectorSignal = x(i - filtLgth +1 : i)';
       filterSignal(i) = weights * vectorSignal;
    end    
end

for i = 1:SysOrder
    weights(i) = swarm(gbest,3,i) ;
end
yd= SglWithWghts(weights , x,N,SysOrder);
error = yd -d;
hold on
subplot(221),plot(t,d),ylabel('Desired Signal'),
subplot(222),plot(t,x),ylabel('Input Signal+Noise'),
subplot(223),plot(t,error),ylabel('Error'),
subplot(224),plot(t,yd),ylabel('Adaptive Desired output');

hold off;
