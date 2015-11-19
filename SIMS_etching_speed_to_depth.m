% Changes SIMS speed of etching to depth
%% Input
mk_Clear
cd('c:\Users\DUIN\Downloads');
x_measured          = importdata('c:\Users\DUIN\Downloads\x_measured.txt'); % data, input from console or from file
interface_planned_um   = [4.5, 6.1228, 11.6228]; %[4.5, 6.1228, 11.6228]; %[4.5, 6.1228, 9.6228]; %[ 4.5, 6.1228, 11.6228]; % planned depths of interfaces  (um)
interface_measured_sims  = [635.7, 895, 1635]; %[1056.6, 1493.5, 2756]; %[618.04, 883.04, 1342.77]; %[ 722.77, 1016.6, 1847.5]; % measured depths of interfaces (arb. u.)

%% Calc

% check
if length(interface_planned_um) ~= length(interface_measured_sims)
    error('Lengths of interface vectors must be equal.')
end

% interface_planned and interface_measured must start with zero
if interface_planned_um(1) ~= 0
    interface_planned_um = [0, interface_planned_um];
    interface_measured_sims = [0, interface_measured_sims];
end

% initials
scaling_factor = zeros(length(interface_planned_um)-1,1);
x_scaled = [];

% factors
for i=1:1:(length(interface_planned_um)-1)
    scaling_factor(i) = (interface_planned_um(i+1) - interface_planned_um(i)) / (interface_measured_sims(i+1) - interface_measured_sims(i));
end

% do scale
for i=1:1:(length(interface_planned_um)-1)
    if i < (length(interface_planned_um)-1)
        x_scaled = [x_scaled;  interface_planned_um(i) + scaling_factor(i) * ( x_measured(x_measured > interface_measured_sims(i) & x_measured <= interface_measured_sims(i+1)) - interface_measured_sims(i))];
    else % x_scaled calculated for x_measured smaller AND greater than the last interface
        x_scaled = [x_scaled;  interface_planned_um(i) + scaling_factor(i) * ( x_measured(x_measured > interface_measured_sims(i)                                        ) - interface_measured_sims(i))];
    end
end

% save
dlmwrite('x_scaled.txt', x_scaled);

    
    
    