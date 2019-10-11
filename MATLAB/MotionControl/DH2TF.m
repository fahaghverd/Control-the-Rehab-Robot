function [ T_end , j,T_array ] = DH2TF(q1,q2,q3)
syms q1 q2 q3;
DH_table=[0  -pi/2 0 q1;0 pi/2 0 pi/2-q2;0 0 0 q3];
T_array = cell(1,size(DH_table,1));
T_end = eye(4);
Z_array=cell(1,size(DH_table,1));
z0=[0;0;1];
P_array=cell(1,size(DH_table,1));
p0=[0;0;0];
for i = 1:size(DH_table,1)
a = DH_table(i,1);
alpha = DH_table(i,2);
d = DH_table(i,3);
theta = DH_table(i,4);
sinTheta = sin(theta);
cosTheta = cos(theta);
sinAlpha = sin(alpha);
cosAlpha = cos(alpha);
T = [cosTheta -sinTheta*cosAlpha sinTheta*sinAlpha a*cosTheta;
sinTheta cosTheta*cosAlpha -cosTheta*sinAlpha a*sinTheta;
0 sinAlpha cosAlpha d;
0 0 0 1];
T_array{i} = T;
T_end = T_end*T;
Z_array{i}=T_end(1:3,3);
P_array{i}=T_end(1:3,4);
end
T_end
j=[cross(z0,(P_array{3}-p0)) cross(Z_array{1},(P_array{3}-P_array{1})) cross(Z_array{2},(P_array{3}-P_array{2}));z0 Z_array{1} Z_array{2}] %jacobian matrix of end_effector
end

