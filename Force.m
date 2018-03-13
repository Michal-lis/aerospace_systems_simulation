%Si³a
clear;
clc;

alfatab=[0:5:90]
Vtab=[50:5:100]

i=1;
j=1;
for alfa=0:5:90
    for V=50:5:100
        F(i,j)=1*1*cosd(alfa)*V^2*0.5
        i=i+1;
    end
    i=1;
    j=j+1;
end
v=44.7
a=56.7
sim('Fsil')