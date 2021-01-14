syms tau1 q1 q1d q1dd m1 b1 fk1 ...
tau2 q2 q2d q2dd m2 b2 fk2 ...
tau3 q3 q3d q3dd m3 b3 fk3 ...
Pc1x Pc1y Pc1z Ic1xx Ic1xy Ic1xz Ic1yy Ic1yz Ic1zz ...
Pc2x Pc2y Pc2z Ic2xx Ic2xy Ic2xz Ic2yy Ic2yz Ic2zz ...
Pc3x Pc3y Pc3z Ic3xx Ic3xy Ic3xz Ic3yy Ic3yz Ic3zz ...
g
DH_table=[0  -pi/2 0 q1;0 pi/2 0 pi/2-q2;0 0 0 q3];
Tau = [tau1; tau2; tau3];
Q = [q1;q2;q3];
Qd = [q1d;q2d;q3d];
Qdd = [q1dd;q2dd;q3dd];
B = [b1;b2;b3];
Fk = [fk1;fk2;fk3];
Pc1 = [Pc1x Pc1y Pc1z].';
Pc2 = [Pc2x Pc2y Pc2z].';
Pc3 = [Pc3x Pc3y Pc3z].';
Ic1 = [Ic1xx -Ic1xy -Ic1xz;
-Ic1xy Ic1yy -Ic1yz;
-Ic1xz -Ic1yz Ic1zz];
Ic2 = [Ic2xx -Ic2xy -Ic2xz;
-Ic2xy Ic2yy -Ic2yz;
-Ic2xz -Ic2yz Ic2zz];
Ic3 = [Ic3xx -Ic3xy -Ic3xz;
-Ic3xy Ic3yy -Ic3yz;
-Ic3xz -Ic3yz Ic3zz];
%% Forward Kinematics
[~,~,T_array] = DH2TF(q1,q2,q3);
%% Newton-Euler Dynamics
m = [m1;m2;m3];
Pc = {Pc1 Pc2 Pc3};
Ic = {Ic1 Ic2 Ic3};
g0 = [0; g; 0];
MVG = NewtonEuler(m,Pc,Ic,T_array,Qd,Qdd,g0);
MVG = simplify(expand(MVG));
%% Separate MVG into M, V, and G
[M,V,G] = SeparateMVG(MVG,Qdd,g)
%% Get Equation of Motion
% EOM = Tau == M*Qdd + V + G + B.*Qd + Fk.*sign(Qd)
% m1=1.915; %PS
% m2=0.565; %FE
% m3=0.391; %RU
% I1=[9992.222 1065.697 0;1065.697 31758.861 0;0 0 3446.081]*0.001; %PS kg.mm
% I2=[3068.769 11.142 -102.811;11.142 3171.346 -559.828;-102.811 -559.828 1188.929]*0.001; %FE
% I3=[1233.065 -143.729 287.129;-143.729 986.395 353.242;287.129 353.242 665.622]*0.001; %RU
% Ic1xx=I1(1,1);
% Ic2xx=I2(1,1);
% Ic3xx=I3(1,1);
% Ic1xy=-I1(1,2);
% Ic2xy=-I2(1,2);
% Ic3xy=-I3(1,2);
% Ic1xz=-I1(1,3);
% Ic2xz=-I2(1,3);
% Ic3xz=-I3(1,3);
% Ic1yy=I1(2,2);
% Ic2yy=I2(2,2);
% Ic3yy=I3(2,2);
% Ic1yz=-I1(2,3);
% Ic2yz=-I2(2,3);
% Ic3yz=-I3(2,3);
% Ic1zz=I1(3,3);
% Ic2zz=I2(3,3);
% Ic3zz=I3(3,3);
% Pc1=[-21.685;-62.753;0]*0.001; %PS mm
% Pc1x=Pc1(1);
% Pc1y=Pc1(2);
% Pc1z=Pc1(3);
% Pc2=[1.92;-79.035;39.864]*0.001; %FE
% Pc2x=Pc2(1);
% Pc2y=Pc2(2);
% Pc2z=Pc2(3);
% Pc3=[57.868;12.720;16.527]*0.001; %RU
% Pc3x=Pc1(1);
% Pc3y=Pc1(2);
% Pc3z=Pc1(3);
% b=[0.0252; 0.0019; 0.0029]; %Nms/rad
% b1=1.915; %PS
% b2=0.565; %FE
% b3=0.391; %RU
% fk=[0.1891; 0.0541; 0.1339]; %Nm
% fk1=1.915; %PS
% fk2=0.565; %FE
% fk3=0.391; %RU
% subs(EOM)
