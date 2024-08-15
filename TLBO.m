clc;
clear;
close all;
%% Problem Definition
% Cost Function
CostFunction = @(x, y) Sphere(x, y);
nVar = 2;            % Number of Unknown Variables
VarMin =1;        % Unknown Variables Lower Bound
VarMax =5;        % Unknown Variables Upper Bound
%% TLBO Parameters
MaxIt = 1000;        % Maximum Number of Iterations
nPop = 50;           % Population Size
%% Initialization 
% Empty Structure for Individuals
empty_individual.Position = [];
empty_individual.Cost = [];
% Initialize Population Array
pop = repmat(empty_individual, nPop, 1);
% Initialize Best Solutions
BestSols = repmat(empty_individual, 3, 1);
for i = 1:3
    BestSols(i).Cost = inf;
end
% Initialize Population Members
for i=1:nPop
    x = round(rand*(VarMax - VarMin) + VarMin);
    y = round(rand*(VarMax - VarMin) + VarMin);
    pop(i).Position = [x, y];
    pop(i).Cost = CostFunction(pop(i).Position(1), pop(i).Position(2));
    
    % Update BestSols
    for j = 1:3
        if pop(i).Cost < BestSols(j).Cost
            BestSols(j) = pop(i);
            break;
        end
    end
end
% Initialize Best Cost Records
BestCosts = zeros(MaxIt, 1);
%% TLBO Main Loop
for it = 1:MaxIt
    
    % Calculate Population Mean
    Mean = zeros(1, nVar);
    for i = 1:nPop
        Mean = Mean + pop(i).Position;
    end
    Mean = Mean/nPop;
    
    % Select Teacher
    Teacher = pop(1);
    for i = 2:nPop
        if pop(i).Cost < Teacher.Cost
            Teacher = pop(i);
        end
    end
    
    % Teacher Phase
    for i = 1:nPop
        % Create Empty Solution
        newsol = empty_individual;
        
        % Teaching Factor
        TF = randi([1 2]);
        
        % Teaching (moving towards teacher)
        newsol.Position = pop(i).Position ...
            + round(rand([1, nVar]).*(Teacher.Position - TF*Mean));
        
        % Clipping
        newsol.Position = max(newsol.Position, VarMin);
        newsol.Position = min(newsol.Position, VarMax);
        
        % Evaluation
        newsol.Cost = CostFunction(newsol.Position(1), newsol.Position(2));
        
        % Update BestSols
        for j = 1:3
            if newsol.Cost < BestSols(j).Cost
                BestSols(j) = newsol;
                break;
            end
        end
    end
    
    % Learner Phase
    for i = 1:nPop
        
        A = 1:nPop;
        A(i) = [];
        j = A(randi(nPop-1));
        
        Step = pop(i).Position - pop(j).Position;
        if pop(j).Cost < pop(i).Cost
            Step = -Step;
        end
        
        % Create Empty Solution
        newsol = empty_individual;
        
        % Teaching (moving towards teacher)
        newsol.Position = pop(i).Position + round(rand([1, nVar]).*Step);
        
        % Clipping
        newsol.Position = max(newsol.Position, VarMin);
        newsol.Position = min(newsol.Position, VarMax);
        
        % Evaluation
        newsol.Cost = CostFunction(newsol.Position(1), newsol.Position(2));
        
        % Update BestSols
        for j = 1:3
            if newsol.Cost < BestSols(j).Cost
                BestSols(j) = newsol;
                break;
            end
        end
    end
    
    % Store Record for Current Iteration
    BestCosts(it) = BestSols(1).Cost; % Store the best cost
    
    % Show Iteration Information
    
    
end
disp(['After Iteration ' num2str(it) ': Top 3 Solutions = [' num2str(BestSols(1).Position(1)) ', ' num2str(BestSols(1).Position(2)) '], [' ...
        num2str(BestSols(2).Position(1)) ', ' num2str(BestSols(2).Position(2)) '], [' ...
        num2str(BestSols(3).Position(1)) ', ' num2str(BestSols(3).Position(2)) ']']);
%% Results
figure;
semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteration');
ylabel('Best Cost');
grid on;

function z = Sphere(x, y)
    %Objective Function x->no of staions at each location, y->no of points at each stations
    z = sum(x*y*50*(10^3))+sum((0.5*0.5^((x*y)+1))/(fact(((x*y)-1))*((x*y)-1)))/5.6;
end
function y = fact(n)
% This function calculates the factorial of a non-negative integer
  % Base case: factorial(0) = 1
  if n == 0
    y = 1;
    return;
  end

  j=1; i=1;
while i<=10
    j=j*i;
    i=i+1;
end
y=j;
return
end
