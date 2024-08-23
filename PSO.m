clc 
clear 

%% parameters%%
Max_iter = 50; % Maximum Number of Iterations
inertia = 0.3; %Ineritia coefficient
c_1 = 2; %cognitive constant
c_2 = 2;%social constant
swarm_size  = 5; %swarm size
Min = -5.12;
Max = 5.12;
N = 5; 
%% giving intial position and velocity  to zero and best_fitness value to 1000.
swarm = zeros(swarm_size,4,N);
for i=  1:swarm_size 
    for j = 1:N
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
      for j = 1: N
        swarm(i ,1,j)  =  swarm(i ,1,j) + swarm(i ,2,j);% updating the position of particle x-dimension
      end
        position = [swarm(i , 1,:)]; % particle position in form of matrix
        % fval =  DeJong(position);
        fval =  rastrigin(position);

        if fval < swarm(i,4) %if fitness value  is better than best -fitness of particle then
            for j = 1 : N
             swarm(i,3,j)  = swarm(i ,1,j); %change both values First Dimension of best fitness vector
            end
            swarm(i ,4) = fval; %update the best fitness value of the particle
        end
      

    end
    [target , gbest] = min(swarm(:,4)); %gbest will store the i the value of the particle in which gbest value is found
    for i = 1 :swarm_size 
        for j  = 1 : N
            swarm(i,2,j) = inertia * swarm(i,2,j)  + c_1 * rand * (swarm(i,3,j) - swarm(i,1,j)) +  c_2 * rand * (swarm(gbest,3,j) - swarm(i,1,j));
        end
    end

    % Now store the best global value in the convergence curve
    ConvCurve(1,iter) = swarm(gbest,4); % fitness value showing curve
    ConCurveVel(1,iter) = sum(sqrt(swarm(:,2).^2)); % total  velocity showing curve
end  


%% Declaring function
% function decleartion of rastrigin function
function [y] = rastrigin(x)
    d = length(x);
    sq = x.^2;   
    y = 10*d + sum(sq - 10*cos(2*pi*x));
end

%function declearation of DeJong function
function [X] = DeJong(x)
    X = sum(x.^2);
end

%% Ploting the fitness  and  velocity vs no of iteration
tiledlayout(2,1)
% Top Plot
nexttile
plot(ConvCurve)
title('Fitness vs no. of iterations')
xlabel('iteration')
ylabel("Fitness Value")

% Bottom Plot
nexttile
plot(ConCurveVel)
title('Velocity vs No. of iterations')
xlabel('iteration')
ylabel('Total velocity')
