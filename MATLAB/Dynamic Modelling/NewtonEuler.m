function [Tau,w,wd,vd,vcd,F,N,f,n] = NewtonEuler(m,Pc,Ic,T_array,Qd,Qdd,g0)
num = 3;
% Pad vectors for notation consistency
m = [0; m];
Pc = [0 Pc];
Ic = [0 Ic];
Qd = [0; Qd];
Qdd = [0; Qdd];
% Local X vector
Z = [0; 0; 1];
% Frame 0 Variables
w{1} = [0 0 0].';
wd{1}= [0 0 0].';
% Gravity Orientation
G = -g0;
vd{1} = G;
%% Outward Iterations
for i = 1:num % 0 -> n-1
R = T_array{i}(1:3,1:3).'; % ^i+1_i R
P = T_array{i}(1:3,4); % ^i P_i+1
w{i+1} = R*w{i} + Qd(i+1)*Z; % 6.45
wd{i+1} = R*wd{i} + cross(R*w{i},Qd(i+1)*Z) + Qdd(i+1)*Z; % 6.46
vd{i+1} = R*(cross(wd{i},P) + cross(w{i},cross(w{i},P)) + vd{i}); % 6.47
vcd{i+1} = cross(wd{i+1},Pc{i+1}) + cross(w{i+1},cross(w{i+1},Pc{i+1}))+vd{i+1}; % 6.48
F{i+1} = m(i+1)*vcd{i+1}; % 6.49
N{i+1} = Ic{i+1}*wd{i+1} + cross(w{i+1},Ic{i+1}*w{i+1}); % 6.50
end
%% Inward Iterations
for i = num+1:-1:2 % n -> 1
if i == num+1
f{i} = F{i}; % 6.51
n{i} = N{i} + cross(Pc{i},F{i}); % 6.52
else
R = T_array{i}(1:3,1:3);
P = T_array{i}(1:3,4);
f{i} = R*f{i+1} + F{i}; % 6.51
n{i} = N{i} + R*n{i+1} + cross(Pc{i},F{i}) + cross(P,R*f{i+1}); % 6.52
end
Tau(i,1) = n{i}.'*Z; % 6.53
end
%% Clean up elements related to 0th frame
Tau(1) = [];
w(:,1) = [];
wd(:,1) = [];
vd(:,1) = [];
vcd(:,1) = [];
F(:,1) = [];
N(:,1) = [];
f(:,1) = [];
n(:,1) = [];
end