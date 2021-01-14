function [M,V,G] = SeparateMVG(MVG,Qdd,g)
n = length(MVG);
% Extract M
for i = 1:n
mvg = MVG(i);
for j = 1:n
m_temp = char(collect(mvg,Qdd(j)));
ind = strfind(m_temp,char(Qdd(j)));
if length(ind) < 2
m = m_temp(1:ind-2);
M(i,j) = simplify(expand(evalin('base',m)));
else
error(['Could not collect ' char(Qdd(j)) '.'])
end
end
end
% Reduce MVG to VG
VG = simplify(expand(MVG - M*Qdd));
for i = 1:n
vg = VG(i);
g_temp = char(collect(vg,g));
ind = strfind(g_temp,char(g));
if length(ind) < 2
g_i = g_temp(1:ind-2);
else
error(['Could not collect ' char(g) '.'])
end
G(i,1) = simplify(expand(evalin('base',g_i)))*g;
end
% Reduce VG to V
V = simplify(expand(VG-G));
end