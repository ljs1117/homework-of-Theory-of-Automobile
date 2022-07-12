clear

nt=[0,762.6,1273,1622,1774.9,2300.1];
Tt=[1111.3,687.8,471.5,358.5,304.6,36.76];
Pt=[0,54.84,62.85,60.89,56.61,8.85];
np=[1854,1864.5,1920,2027.5,2105.5,2300.1];
load('Pt1.mat')
load('ne.mat')
load('Tt1.mat')

n=0:2300;
plot(n,Tt1(n),n,Pt1(n)*10);
title('发动机与液力变矩器共同工作的输出特性');
xlabel('涡轮轴转速nT/(r/min)');
ylabel('转矩Tt（N·m）功率Pt*10（kW）');
legend("Tt","Pt*10");

%绘制牵引特性曲线
r=0.367;
yita=0.85;
ig1=14.26;
ig2=9.78;
ig3=6.7;
ig4=4.58;
ig5=3.77;
ig6=3.11;
ig7=2.58;
ig8=2.13;
ig9=1.77;
ig10=1.46;
ig11=1.21;
ig12=1;
i0=5.176;

Ft1=Tt1(n).*ig1*i0*yita/r;
Ft2=Tt1(n).*ig2*i0*yita/r;
Ft3=Tt1(n).*ig3*i0*yita/r;
Ft4=Tt1(n).*ig4*i0*yita/r;
Ft5=Tt1(n).*ig5*i0*yita/r;
Ft6=Tt1(n).*ig6*i0*yita/r;
Ft7=Tt1(n).*ig7*i0*yita/r;
Ft8=Tt1(n).*ig8*i0*yita/r;
Ft9=Tt1(n).*ig9*i0*yita/r;
Ft10=Tt1(n).*ig10*i0*yita/r;
Ft11=Tt1(n).*ig11*i0*yita/r;
Ft12=Tt1(n).*ig12*i0*yita/r;

ua1=0.377*r.*n./(ig1*i0);
ua2=0.377*r.*n./(ig2*i0);
ua3=0.377*r.*n./(ig3*i0);
ua4=0.377*r.*n./(ig4*i0);
ua5=0.377*r.*n./(ig5*i0);
ua6=0.377*r.*n./(ig6*i0);
ua7=0.377*r.*n./(ig7*i0);
ua8=0.377*r.*n./(ig8*i0);
ua9=0.377*r.*n./(ig9*i0);
ua10=0.377*r.*n./(ig10*i0);
ua11=0.377*r.*n./(ig11*i0);
ua12=0.377*r.*n./(ig12*i0);
plot(ua1,Ft1,ua2,Ft2,ua3,Ft3,ua4,Ft4,ua5,Ft5,ua6,Ft6,ua7,Ft7,ua8,Ft8,ua9,Ft9,ua10,Ft10,ua11,Ft11,ua12,Ft12);
title('发动机与液力变矩器共同工作的牵引特性曲线');
xlabel('行驶速度ua/(km/h)');
ylabel('驱动力Ft（N·m）');
legend("Ⅰ档","Ⅱ档","Ⅲ档","Ⅳ档","Ⅴ档","Ⅵ档","Ⅶ档","Ⅷ档","Ⅸ档","Ⅹ档","Ⅺ档","Ⅻ档");



%不同坡度下最大速度
ua=0:180;
G=3880;
CdA=2.77;
f=0.014*(1+(ua.^2/19400));
%i=0
Ff1=G*f;
Fw1=CdA/21.15.*ua.^2;
Fi1=0;
%i=0.15
Ff2=G*f*cos(0.15);
Fw2=CdA/21.15.*ua.^2;
Fi2=G*sin(0.15);
%i=0.3
Ff3=G*f*cos(0.3);
Fw3=CdA/21.15.*ua.^2;
Fi3=G*sin(0.3);
plot(ua1,Ft1,ua2,Ft2,ua3,Ft3,ua4,Ft4,ua5,Ft5,ua6,Ft6,ua7,Ft7,ua8,Ft8,ua9,Ft9,ua10,Ft10,ua11,Ft11,ua12,Ft12,ua,Ff1+Fw1+Fi1,ua,Ff2+Fw2+Fi2,ua,Ff3+Fw3+Fi3);
title('驱动力-行驶阻力平衡图');
xlabel('行驶速度ua/(km/h)');
ylabel('力Ft（N·m）');
legend("Ⅰ档","Ⅱ档","Ⅲ档","Ⅳ档","Ⅴ档","Ⅵ档","Ⅶ档","Ⅷ档","Ⅸ档","Ⅹ档","Ⅺ档","Ⅻ档","Ff+Fw+Fi(i=0)","Ff+Fw+Fi(i=0.15)","Ff+Fw+Fi(i=0.3)");

