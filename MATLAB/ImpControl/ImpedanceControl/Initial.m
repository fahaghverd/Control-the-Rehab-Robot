clc;clear all;
global xi hA Ts tf q_des
% %% Initial Configuration of links
% x0 = [1; 0.1];
% q0 = Model_invKinematics(x0);          % initial angles 
% qd0 = [0;0];                 % initial angular velocities
%% Trajectory Initilization
xi = [0 ;0 ; 0];        % Initial Point
q_des=[30;10;10];
q_des=q_des*(pi/180);
%hA = 100*[1;1;1];       % Desired Contact Force
%% Simulation Settings
Ts = 0.000001;            % Sampling Time (if required)
tf = 15;               % Total Time
%% Choose the Controller
sim ImpedanceControl


