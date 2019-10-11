function [T_end, j ,JD,T] = KinematicModel(q1,q2,q3,dq1,dq2,dq3)
j=[ 0,        0,                       0
 0,        0,                       0
 0,        0,                       0
 0, -sin(q1), -cos(q1)*sin(q2 - pi/2)
 0,  cos(q1), -sin(q1)*sin(q2 - pi/2)
 1,        0,          cos(q2 - pi/2)];
JD=[0 0 0
    0 0 0
    0 0 0
    0 dq1*cos(q1) -sin(q1)*sin(q2-pi/2)*dq1+cos(q1)*cos(q2)*dq2
    0 dq1*sin(q1) cos(q1)*sin(q2-pi/2)*dq1+sin(q1)*cos(q2)*dq2
    0 0 -sin(q2)*dq2];
T_end =[ cos(q1)*cos(q3)*cos(q2 - pi/2) - sin(q1)*sin(q3), - cos(q3)*sin(q1) - cos(q1)*cos(q2 - pi/2)*sin(q3), -cos(q1)*sin(q2 - pi/2), 0
 cos(q1)*sin(q3) + cos(q3)*cos(q2 - pi/2)*sin(q1),   cos(q1)*cos(q3) - cos(q2 - pi/2)*sin(q1)*sin(q3), -sin(q1)*sin(q2 - pi/2), 0
                           cos(q3)*sin(q2 - pi/2),                            -sin(q3)*sin(q2 - pi/2),          cos(q2 - pi/2), 0
                                                0,                                                  0,                       0, 1];


