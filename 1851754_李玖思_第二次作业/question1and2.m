clear
%相关参数导入
n=800:5500;
r=0.269;
ig1=3.455;
ig2=1.944;
ig3=1.286;
ig4=0.969;
ig5=0.800;
i0=4.111;
yita=0.95;
m=1460;
G=1460*9.8;
CdA=0.37*1.96;

Ttq=45.22+123.5*(n/1000)-91.43*(n/1000).^2+47.34*(n/1000).^3-14.11*(n/1000).^4+2.084*(n/1000).^5-0.1187*(n/1000).^6;

Iw=2.4;
If=0.218;

a=1.4;
L=2.7;
hg=0.57;

%驱动力计算
Ft1=Ttq.*ig1*i0*yita/r;
Ft2=Ttq.*ig2*i0*yita/r;
Ft3=Ttq.*ig3*i0*yita/r;
Ft4=Ttq.*ig4*i0*yita/r;
Ft5=Ttq.*ig5*i0*yita/r;
%汽车行驶速度
ua1=0.377*r.*n./(ig1*i0);
ua2=0.377*r.*n./(ig2*i0);
ua3=0.377*r.*n./(ig3*i0);
ua4=0.377*r.*n./(ig4*i0);
ua5=0.377*r.*n./(ig5*i0);

ua=0:10:180;
%滚动阻力系数
f=0.014*(1+(ua.^2/19400));
Ff=G*f;

f1=0.014*(1+(ua1.^2/19400));
Ff1=G*f1;
f2=0.014*(1+(ua2.^2/19400));
Ff2=G*f2;
f3=0.014*(1+(ua3.^2/19400));
Ff3=G*f3;
f4=0.014*(1+(ua4.^2/19400));
Ff4=G*f4;
f5=0.014*(1+(ua5.^2/19400));
Ff5=G*f5;

%风阻
Fw=CdA/21.15.*ua.^2;

Fw1=CdA/21.15.*ua1.^2;
Fw2=CdA/21.15.*ua2.^2;
Fw3=CdA/21.15.*ua3.^2;
Fw4=CdA/21.15.*ua4.^2;
Fw5=CdA/21.15.*ua5.^2;

%绘制驱动力-行驶阻力平衡图
figure(1);
plot(ua1,Ft1,ua2,Ft2,ua3,Ft3,ua4,Ft4,ua5,Ft5,ua,Ff+Fw);
title('驱动力-行驶阻力平衡图')
xlabel('u(km/h)')
ylabel('Ft(N)')
legend("Ⅰ档","Ⅱ档","Ⅲ档","Ⅳ档","Ⅴ档");
%绘制汽车动力特性图
figure(2)
plot(ua1,(Ft1-Fw1)/G,ua2,(Ft2-Fw2)/G,ua3,(Ft3-Fw3)/G,ua4,(Ft4-Fw4)/G,ua5,(Ft5-Fw5)/G,ua,f);
title('动力特性图')
xlabel('u(km/h)')
ylabel('D')
legend("Ⅰ档","Ⅱ档","Ⅲ档","Ⅳ档","Ⅴ档");
%绘制功率平衡图
figure(3)
Pe=Ttq.*n/9550;
Pfandw=1/yita*(G*f.*ua/3600+CdA*ua.^3/76140);
plot(ua1,Pe,ua2,Pe,ua3,Pe,ua4,Pe,ua5,Pe,ua,Pfandw);
title('功率平衡图')
xlabel('u(km/h)')
ylabel('P(kW)')
legend("Ⅰ档","Ⅱ档","Ⅲ档","Ⅳ档","Ⅴ档","(Pf+Pw)/yita");

 %求解最大爬坡度（一般为Ⅰ档）
im=tan(asin(max((Ft1-(Ff1+Fw1))/G)));
disp(['im(最大爬坡度）=' num2str(im)]);

%求解汽车加速时间
%加速度倒数曲线
a1=(Ft1-Ff1-Fw1)/((1+Iw/(m*r^2)+(If*ig1^2*i0^2*yita)/(m*r^2))*m);inv_a1=1./a1;
a2=(Ft2-Ff2-Fw2)/((1+Iw/(m*r^2)+(If*ig2^2*i0^2*yita)/(m*r^2))*m);inv_a2=1./a2;
a3=(Ft3-Ff3-Fw3)/((1+Iw/(m*r^2)+(If*ig3^2*i0^2*yita)/(m*r^2))*m);inv_a3=1./a3;
a4=(Ft4-Ff4-Fw4)/((1+Iw/(m*r^2)+(If*ig4^2*i0^2*yita)/(m*r^2))*m);inv_a4=1./a4;
a5=(Ft5-Ff5-Fw5)/((1+Iw/(m*r^2)+(If*ig5^2*i0^2*yita)/(m*r^2))*m);inv_a5=1./a5;
figure(4)
title('加速度倒数曲线')
xlabel('u(km/h)')
ylabel('1/a')
plot(ua1,inv_a1,ua2,inv_a2,ua3,inv_a3,ua4,inv_a4,ua5,inv_a5);
title('加速度倒数曲线')
xlabel('u(km/h)')
ylabel('1/a(s^2/m)')
legend("Ⅰ档","Ⅱ档","Ⅲ档","Ⅳ档","Ⅴ档");
axis([0 160 0 10])

%绘制一档起步加速至100km/h的加速曲线
U0=100;
ig=[3.455;1.944;1.286;0.969;0.800];
for i=1:5
Ua(i,1)=(800*0.377*r)/(ig(i)*i0);
if (5500*0.377*r)/(ig(i)*i0)<U0
Ua(i,2)=(5500*0.377*r)/(ig(i)*i0);
else
Ua(i,2)=U0;
end
end
Ua1=Ua(1,1):0.0001:Ua(1,2);
n1=i0*ig1.*Ua1/0.377/r;
Fw11=CdA/21.15.*Ua1.^2;
Ft11=(45.22+123.5*(n1/1000)-91.43*(n1/1000).^2+47.34*(n1/1000).^3-14.11*(n1/1000).^4+2.084*(n1/1000).^5-0.1187*(n1/1000).^6).*ig1*i0*yita/r;
f11=0.014*(1+(Ua1.^2/19400));
Ff11=G*f11;
a11=(Ft11-Ff11-Fw11)/((1+Iw/(m*r^2)+(If*ig1^2*i0^2*yita)/(m*r^2))*m);inv_a11=1./a11/3.6;
t1=cumtrapz(Ua1,inv_a11);
t11=trapz(Ua1,inv_a11);

Ua2=Ua(1,2):0.0001:Ua(2,2);
n2=i0*ig2.*Ua2/0.377/r;
Fw22=CdA/21.15.*Ua2.^2;
Ft22=(45.22+123.5*(n2/1000)-91.43*(n2/1000).^2+47.34*(n2/1000).^3-14.11*(n2/1000).^4+2.084*(n2/1000).^5-0.1187*(n2/1000).^6).*ig2*i0*yita/r;
f22=0.014*(1+(Ua2.^2/19400));
Ff22=G*f22;
a22=(Ft22-Ff22-Fw22)/((1+Iw/(m*r^2)+(If*ig2^2*i0^2*yita)/(m*r^2))*m);inv_a22=1./a22/3.6;
t2=cumtrapz(Ua2,inv_a22);
t22=trapz(Ua2,inv_a22);

Ua3=Ua(2,2):0.0001:Ua(3,2);
n3=i0*ig3.*Ua3/0.377/r;
Fw33=CdA/21.15.*Ua3.^2;
Ft33=(45.22+123.5*(n3/1000)-91.43*(n3/1000).^2+47.34*(n3/1000).^3-14.11*(n3/1000).^4+2.084*(n3/1000).^5-0.1187*(n3/1000).^6).*ig3*i0*yita/r;
f33=0.014*(1+(Ua3.^2/19400));
Ff33=G*f33;
a33=(Ft33-Ff33-Fw33)/((1+Iw/(m*r^2)+(If*ig3^2*i0^2*yita)/(m*r^2))*m);inv_a33=1./a33/3.6;
t3=cumtrapz(Ua3,inv_a33);
t33=trapz(Ua3,inv_a33);

figure(5)
plot(t1,Ua1,t2+t11,Ua2,t3+t11+t22,Ua3)
grid on;
title('加速时间曲线');
xlabel('t/s');
ylabel('u/(km/h)');
t=t11+t22+t33;
disp(['t(一档起步加速至100km/h所需加速时间）=' num2str(t)]);

%一档和二档加速上坡（假设坡度为10°）
asp1=(Ft1-Ff1*cos(10/180*pi)-Fw1-G*sin(10/180*pi))/((1+Iw/(m*r^2)+(If*ig1^2*i0^2*yita)/(m*r^2))*m);
C1=(tan(10/180*pi)+1/9.8*1/cos(10/180*pi).*asp1)./(a/L+hg/L*(tan(10/180*pi)+1/9.8*1/cos(10/180*pi).*asp1));
asp2=(Ft2-Ff2*cos(10/180*pi)-Fw2-G*sin(10/180*pi))/((1+Iw/(m*r^2)+(If*ig2^2*i0^2*yita)/(m*r^2))*m);
C2=(tan(10/180*pi)+1/9.8*1/cos(10/180*pi).*asp2)./(a/L+hg/L*(tan(10/180*pi)+1/9.8*1/cos(10/180*pi).*asp2));
figure(6)
plot(ua1,C1,ua2,C2);
title('全力加速上坡时附着率曲线');
xlabel('u/(km/h)');
ylabel('C');
legend("Ⅰ档","Ⅱ档");


















