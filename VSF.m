clear all;

% Branch data: Branch Number, INbus, OUTbus, Resistance(pu), Reactance(pu)
LD = [
    1 1 2 0.001 -206.46
    2 2 3 0.001 -206.46
    3 3 4 0.001 -206.46
    4 2 5 0.001 -206.46
    5 5 6 0.001 -206.46
    6 6 7 0.001 -206.46
    7 5 8 0.001 -206.46
    8 8 9 0.001 -206.46
    9 8 10 0.001 -206.46
    10 10 11 0.001 -206.46
    11 10 12 0.001 -206.46
    12 12 13 0.001 -206.46
    13 12 15 0.001 -206.46
    14 13 14 0.001 -206.46
    15 15 16 0.001 -206.46
];

% Bus data: Bus Number, Active Power (pu), Reactive Power (pu)
BD = [
    1 0.3 0.2
    2 0.3 0.2
    3 0.8 0.5
    4 0.8 0.5
    5 0.6 0.4
    6 0.6 0.4
    7 0.8 0.5
    8 0.7 0.5
    9 0.8 0.5
    10 0.6 0.4
    11 0.3 0.2
    12 0.6 0.4
    13 0.2 0.1
    14 0.8 0.5
    15 1.2 0.8
    16 1.2 0.8
];

% Extracting necessary parameters
N = max(max(LD(:, 2:3))); % Number of buses
S = complex(BD(:, 2), BD(:, 3)); % Complex power injections
VB = ones(N, 1); % Initial bus voltages
Z = complex(LD(:, 4), LD(:, 5)); % Branch impedance

% Initialize variables to store sensitivities
Jacobian = zeros(N); % Jacobian matrix
delta_P = 0.01; % Change in active power injection for sensitivity calculation

% Perform power flow calculation
for iter = 1:10 % Perform power flow iterations (adjust as needed)
    % Backward sweep
    I = conj(S ./ VB);
    IB = zeros(N, 1);
    for i = size(LD, 1):-1:1
        c = find(LD(:, 2) == LD(i, 3));
        if ~isempty(c)
            IB(LD(i, 1)) = I(LD(i, 3)) + sum(IB(LD(c, 1))) - IB(LD(i, 1));
        else
            IB(LD(i, 1)) = I(LD(i, 3));
        end
    end

    % Forward sweep
    for i = 1:size(LD, 1)
        VB(LD(i, 3)) = VB(LD(i, 2)) - IB(LD(i, 1)) * Z(i);
    end
end

% Calculate sensitivity of bus voltages with respect to active power injections
for i = 1:N
    % Perturb active power injection at bus i
    BD_perturbed = BD;
    BD_perturbed(i, 2) = BD_perturbed(i, 2) + delta_P; % Perturb active power at bus i

    % Perform power flow calculation with perturbed active power
    S_perturbed = complex(BD_perturbed(:, 2), BD_perturbed(:, 3));
    VB_perturbed = ones(N, 1);
    IB_perturbed = zeros(N, 1);

    % Backward sweep
    I_perturbed = conj(S_perturbed ./ VB_perturbed);
    for j = size(LD, 1):-1:1
        c = find(LD(:, 2) == LD(j, 3));
        if ~isempty(c)
            IB_perturbed(LD(j, 1)) = I_perturbed(LD(j, 3)) + sum(IB_perturbed(LD(c, 1))) - IB_perturbed(LD(j, 1));
        else
            IB_perturbed(LD(j, 1)) = I_perturbed(LD(j, 3));
        end
    end

    % Forward sweep
    for j = 1:size(LD, 1)
        VB_perturbed(LD(j, 3)) = VB_perturbed(LD(j, 2)) - IB_perturbed(LD(j, 1)) * Z(j);
    end

    % Calculate sensitivity of bus voltages with respect to active power injections
    delta_V = VB_perturbed - VB;
    Jacobian(:, i) = abs(delta_V / (delta_P));
end
%disp(delta_V);
    
disp("Jacobian matrix ((delta_V)i/(delta_P)j):");
disp(Jacobian);