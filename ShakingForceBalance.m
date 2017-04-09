% Known parameters ****************************
clear all
r2=0.04;
r3=0.1;
m2=0.05;
m3=0.15;
m4=0.1;
w2=1800*(2*pi/60);
m3=m2+m4;
gamma=0:0.01:1;
time=0:0.000333:0.0333;
mc=m2;
rc=0.01:0.01:0.04;
rb=(m2/m3)*r3;
ra=r3-rb;


% Equations ***********************************

[x,y]=size(gamma);
[m,n] = size(time);
[a, b] = size(rc);



for i=1:n;
    
    Fsxp(i)=(((m3+m4)*r2))*((w2^2)*cos(w2*time(i)));
    Fsxs(i)=(m4+((ra*m3)/r3))*(((r2^2)*(w2^2)/r3)*cos(2*w2*time(i)));
    Fsy(i)=-(((rb/r3)*m3*r2))*((w2^2)*sin(w2*time(i)));
    Fs(i) = sqrt(((Fsxp(i)+Fsxs(i)).^2)+ ((Fsy(i)).^2));
end


for j = 1:b;
    for k = 1:y
    mc(j)=(((rb/r3)*m3*r2)+(gamma(k)*((ra*m3/r3)+m4)*r2))/rc(j);
    
    for i = 1:n;
    Fsxp1(i)=(((m3+m4)*r2)-(mc(j)*rc(j)))*((w2^2)*cos(w2*time(i)));
    Fsxs1(i)=(m4+((ra*m3)/r3))*(((r2^2)*(w2^2)/r3)*cos(2*w2*time(i)));
    Fsy1(i)=-(((rb/r3)*m3*r2)-(mc(j)*rc(j)))*((w2^2)*sin(w2*time(i)));    
    Fs1(i) = sqrt(((Fsxp1(i)+Fsxs1(i)).^2)+ ((Fsy1(i)).^2));

    end
   if(max(Fs1)<220)        
        mc(j);
        rc(j);
        gamma(k);
                
         max(Fs1);
         c(k) = max(Fs1);
         mini =  min(c);
        
        shakeForce = Fs1;
        balance = mc(j);
        distance = rc(j); 
        
     end
    end   
   
   
   
end

balance
distance

plot(0:0.000333:0.0333,Fs,'b',ylabel('Shaking Force(N)'), xlabel('time(s)'));
hold on
plot(0:0.000333:0.0333, shakeForce, '*', ylabel('Shaking Force(N)'), xlabel('time(s)'));
hold off


