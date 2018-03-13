clc
clear

V=100;

rad2deg(kinem(850));

i = 1;
for x = 50:10:850
    angles = kinem(x);
    fk = fop(angles(1), V);
    A(i,1) = x;
    alpha(i) = angles(1);
    A(i,2) = fa(x,V);
    i = i+1;
end
plot(A(:,1),A(:,2))

i=1;
j=1;
for x=50:10:850
    for V=50:5:100
        F(i,j)=fa(x, V);
        i=i+1;
    end
    i=1;
    j=j+1;
end


function Fa = fa(x, V)

L = [566 800+x];
g = 9.81;
m = 500;           % przyjêliœmy 500kg jako 0,01 masy samolotu
Fg = 5000;        % [N]
angles = kinem(x);

Fax = (Fg*sin(pi/4 - angles(1))*L(2) - fop(angles(1), V)*cos(pi/4 - angles(1))*L(2))/(sin(angles(3))*L(1) + tan(angles(2))*cos(angles(3))*L(1));
Fay = -Fax*tan(angles(2));

Fa = sqrt(Fax^2 + Fay^2);

end


function Fop = fop(alpha, V)

% pole podwozia w mm na podstawie przyblizenia wymiarow z data sheet
pole_podwozia=2338*600*0.5;
% zmiana jednostki z mm na m
pole_podwozia=pole_podwozia*0.000001;
% rzeczywiste pole podwozia w rzucie z przodu
% !!! zmienmy na to, zeby zmiana byla nieliniowa !!!
pole_rzecz=pole_podwozia*rad2deg(alpha)/90;

% gestosc powietrza w kg/m3
ro=1.225;

% V=100;
% wspolczynnik oporu
Cx=0.5;

% sila oporu w N
Fop=0.5*pole_rzecz*ro*Cx*V*V;

end


function angles = kinem(x)

A = [0 0];
B = [1250 400];
O = [0 0];
L = [566 800+x];

a = 2*B(2)*L(1);
b = 2*B(1)*L(1);
c = L(2)^2-B(1)^2-B(2)^2-L(1)^2;

theta = -2*(atan((a-sqrt(a^2 + b^2 - c^2))/(b+c)));
A = [-L(1)*cos(theta) L(1)*sin(theta)];

alpha = 3*pi/4 - theta;

beta = atan((A(2)-B(2))/(A(1)-B(1)));

angles = [alpha beta theta];

end