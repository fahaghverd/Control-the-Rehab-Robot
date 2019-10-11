function [ T_end , j ,JD,ja,T] = DH2TF(q1,q2,q3,dq1,dq2,dq3)
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
R7=T_end(1:3,1:3);
f=atan2(R7(2,1),R7(1,1));
t=atan2(-R7(3,1),sqrt(R7(3,2)^2+R7(3,3)^2));
s=atan2(R7(3,2),R7(3,3)); 
RPY=[s;t;f];
B=[1 0 sin(t);0 cos(s) -cos(t)*sin(s);0 sin(s) cos(t)*sin(s)];
j=[cross(z0,(P_array{3}-p0)) cross(Z_array{1},(P_array{3}-P_array{1})) cross(Z_array{2},(P_array{3}-P_array{2}));z0 Z_array{1} Z_array{2}]; %jacobian matrix of end_effector
JD=[0 0 0,0 0 0,0 0 0,0 dq1*cos(q1) -sin(q1)*sin(q2-pi/2)*dq1+cos(q1)*cos(q2)*dq2,0 dq1*sin(q1) cos(q1)*sin(q2-pi/2)*dq1+sin(q1)*cos(q2)*dq2,0 0 -sin(q2)*dq2]; 
T=[eye(3) zeros(3);zeros(3) inv(B)*RPY];
end

