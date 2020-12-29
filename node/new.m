clc;
close all;
clear all;
syms a;
f=a*exp(a) + sin(a) -1; 
n=input('Enter the number of decimal places:');
epsilon = 5*10^-(n+1)
a0 = input('Enter the first point:');
a1 = input('Enter the second point:');
err=1;
i=0;
while err>epsilon
     f0=vpa(subs(f,a,a0)); 
     f1=vpa(subs(f,a,a1)); 
  out=a1-((f1*(a1-a0))/(f1-f0)); 
  i=i+1; 
err=abs(out-a0);
a0=out;
disp(out);
end
disp("root: ");
disp(out);
fprintf('Iterations : %d\n',i);


clc;
close all;
clear all;
syms a;
f= 4*(a^3) + 2*a - 2; 
n=input('Enter the number of decimal places:');
epsilon = 5*10^-(n+1)
a0 = input('Enter the first point:');
a1 = input('Enter the second point:');
err=1;
i=0;
while err>epsilon
     f0=vpa(subs(f,a,a0)); 
     f1=vpa(subs(f,a,a1));
  out=a1-((f1*(a1-a0))/(f1-f0));
  i=i+1;
err=abs(out-a0);
a0=out;
disp(out);
end
disp("root: ");
disp(out);
fprintf('Iterations : %d\n',i);
