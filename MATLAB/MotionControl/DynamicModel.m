function [ M , V,G ] = DynamicModel(q,qd)

q1=q(1); q2=q(2); q3=q(3);
q1d=qd(1); q2d=qd(2); q3d=qd(3);

m1=1.915; %PS
m2=0.565; %FE
m3=0.391; %RU
I1=[9992.222 1065.697 0;1065.697 31758.861 0;0 0 3446.081]*(0.001^2); %PS kg.mm
I2=[3068.769 11.142 -102.811;11.142 3171.346 -559.828;-102.811 -559.828 1188.929]*(0.001^2); %FE
I3=[1233.065 -143.729 287.129;-143.729 986.395 353.242;287.129 353.242 665.622]*(0.001^2); %RU
Ic1xx=I1(1,1);
Ic2xx=I2(1,1);
Ic3xx=I3(1,1);
Ic1xy=-I1(1,2);
Ic2xy=-I2(1,2);
Ic3xy=-I3(1,2);
Ic1xz=-I1(1,3);
Ic2xz=-I2(1,3);
Ic3xz=-I3(1,3);
Ic1yy=I1(2,2);
Ic2yy=I2(2,2);
Ic3yy=I3(2,2);
Ic1yz=-I1(2,3);
Ic2yz=-I2(2,3);
Ic3yz=-I3(2,3);
Ic1zz=I1(3,3);
Ic2zz=I2(3,3);
Ic3zz=I3(3,3);
Pc1=[-21.685;-62.753;0]*0.001; %PS mm
Pc1x=Pc1(1);
Pc1y=Pc1(2);
Pc1z=Pc1(3);
Pc2=[1.92;-79.035;39.864]*0.001; %FE
Pc2x=Pc2(1);
Pc2y=Pc2(2);
Pc2z=Pc2(3);
Pc3=[57.868;12.720;16.527]*0.001; %RU
Pc3x=Pc1(1);
Pc3y=Pc1(2);
Pc3z=Pc1(3);
% b=[0.0252; 0.0019; 0.0029]; %Nms/rad
% b1=1.915; %PS
% b2=0.565; %FE
% b3=0.391; %RU
% fk=[0.1891; 0.0541; 0.1339]; %Nm
% fk1=1.915; %PS
% fk2=0.565; %FE
% fk3=0.391; %RU
g=-9.81;

M= [ Ic3xx + Ic2yy + Ic1zz + Pc1x^2*m1 + Pc1y^2*m1 + Pc2x^2*m2 + Pc2z^2*m2 + Pc3y^2*m3 + Pc3z^2*m3 - Ic3xx*cos(q3)^2 + Ic3yy*cos(q3)^2 - Ic3xy*sin(2*q3) + Pc3x^2*m3*cos(q3)^2 - Pc3y^2*m3*cos(q3)^2 - Pc3x*Pc3y*m3*sin(2*q3), - Ic2yz - Ic3yz*cos(q3) - Ic3xz*sin(q3) - Pc2y*Pc2z*m2 - Pc3y*Pc3z*m3*cos(q3) - Pc3x*Pc3z*m3*sin(q3), - Ic3yz*cos(q3) - Ic3xz*sin(q3) - Pc3y*Pc3z*m3*cos(q3) - Pc3x*Pc3z*m3*sin(q3)
                                                                                                                     - Ic2yz - Ic3yz*cos(q3) - Ic3xz*sin(q3) - Pc2y*Pc2z*m2 - Pc3y*Pc3z*m3*cos(q3) - Pc3x*Pc3z*m3*sin(q3),                                        m2*Pc2x^2 + m2*Pc2y^2 + m3*Pc3x^2 + m3*Pc3y^2 + Ic2zz + Ic3zz,                                                 m3*Pc3x^2 + m3*Pc3y^2 + Ic3zz
                                                                                                                                            - Ic3yz*cos(q3) - Ic3xz*sin(q3) - Pc3y*Pc3z*m3*cos(q3) - Pc3x*Pc3z*m3*sin(q3),                                                                        m3*Pc3x^2 + m3*Pc3y^2 + Ic3zz,                                                 m3*Pc3x^2 + m3*Pc3y^2 + Ic3zz];

V =[ Ic3yz*q2d^2*sin(q3) - Ic3xz*q2d^2*cos(q3) - Ic3xz*q3d^2*cos(q3) - Ic2xz*q2d^2 + Ic3yz*q3d^2*sin(q3) - 2*Ic2xy*q1d*q2d - Pc2x*Pc2z*m2*q2d^2 - 2*Ic3xz*q2d*q3d*cos(q3) + 2*Ic3yz*q2d*q3d*sin(q3) - 2*Ic3xy*q1d*q2d*cos(2*q3) - 2*Ic3xy*q1d*q3d*cos(2*q3) + Ic3xx*q1d*q2d*sin(2*q3) + Ic3xx*q1d*q3d*sin(2*q3) - Ic3yy*q1d*q2d*sin(2*q3) - Ic3yy*q1d*q3d*sin(2*q3) - Pc3x*Pc3z*m3*q2d^2*cos(q3) - Pc3x*Pc3z*m3*q3d^2*cos(q3) + Pc3y*Pc3z*m3*q2d^2*sin(q3) + Pc3y*Pc3z*m3*q3d^2*sin(q3) - 2*Pc2x*Pc2y*m2*q1d*q2d - Pc3x^2*m3*q1d*q2d*sin(2*q3) - Pc3x^2*m3*q1d*q3d*sin(2*q3) + Pc3y^2*m3*q1d*q2d*sin(2*q3) + Pc3y^2*m3*q1d*q3d*sin(2*q3) - 2*Pc3x*Pc3z*m3*q2d*q3d*cos(q3) + 2*Pc3y*Pc3z*m3*q2d*q3d*sin(q3) - 2*Pc3x*Pc3y*m3*q1d*q2d*cos(2*q3) - 2*Pc3x*Pc3y*m3*q1d*q3d*cos(2*q3)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         (q1d^2*(m3*sin(2*q3)*Pc3x^2 + 2*m3*cos(2*q3)*Pc3x*Pc3y - m3*sin(2*q3)*Pc3y^2 + 2*Ic2xy + 2*Ic3xy*cos(2*q3) - Ic3xx*sin(2*q3) + Ic3yy*sin(2*q3) + 2*Pc2x*Pc2y*m2))/2
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    (q1d^2*(m3*sin(2*q3)*Pc3x^2 + 2*m3*cos(2*q3)*Pc3x*Pc3y - m3*sin(2*q3)*Pc3y^2 + 2*Ic3xy*cos(2*q3) - Ic3xx*sin(2*q3) + Ic3yy*sin(2*q3)))/2];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
G =[g*sin(q1)*(Pc1y*m1 - Pc2z*m2*sin(q2) - Pc3z*m3*sin(q2) + Pc2x*m2*cos(q2) + Pc3x*m3*cos(q2)*cos(q3) - Pc3y*m3*cos(q2)*sin(q3))
 g*(Pc3y*m3*cos(q1)*sin(q3) - Pc3x*m3*cos(q1)*cos(q3) - Pc2x*m2*cos(q1) + Pc2y*m2*sin(q1)*sin(q2) + Pc3y*m3*cos(q3)*sin(q1)*sin(q2) + Pc3x*m3*sin(q1)*sin(q2)*sin(q3))
                                             g*(Pc3y*m3*cos(q1)*sin(q3) - Pc3x*m3*cos(q1)*cos(q3) + Pc3y*m3*cos(q3)*sin(q1)*sin(q2) + Pc3x*m3*sin(q1)*sin(q2)*sin(q3))];






                                         
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    

