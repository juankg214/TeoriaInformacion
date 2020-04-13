close all
clc

function l = Detect_number_of_integrals(x)
  l = [];
  contador = 1;
  for i = 1:length(x)
    if(i==1)
      aux = x(i);    
     else
      if(aux != x(i))
        l(end+1) = contador;
        aux = x(i);
        contador = 1;
       else
        contador++;
       endif
      endif
  endfor
  l(end+1) = contador;
endfunction
k=[1 5 10 20]; 
y=[-1 1 1 -1 1];
T0 = length(y);
l = Detect_number_of_integrals(y);
a0 = 0;
sum = 0;
w = 0;
r=0;

for i=1:length(l)
  sum = sum .+ l(i);
  f = @(x) y(sum);
  w = w .+ (l(i)./length(y)).*T0;
  a0 = a0 + 2/T0.*quad(f,-T0./2.+r,-T0./2.+w);
  r = w;
endfor
f = [" ";" ";" ";" "];
f = cellstr(f);
an = 0;
bn = 0;
sum=0;
r=0;
w=0;
for z=1:length(k)
  for j=1:k(z)
      an = 0;
      bn = 0;
      sum=0;
      r=0;
      w=0;
    for i=1:length(l)
      sum = sum .+ l(i);
      f1 = @(x) y(sum)*cos(j*2*pi/T0*x);
      f2 = @(x) y(sum)*sin(j*2*pi/T0*x);
      w = w .+ (l(i)./length(y)).*T0;
      an = an + 2/T0*quad(f1,-T0./2.+r,-T0./2.+w);
      bn = bn + 2/T0*quad(f2,-T0./2.+r,-T0./2.+w);
      r = w;
    endfor
    #disp(bn);
   aux_car = "+";
   if(j==k(z))
    aux_car = "";
   endif 
    #disp(an);
    f(z) =  strcat(f(z),num2str(an),"*cos(", num2str(j*2*pi/T0),"*x)+", num2str(bn) ,"*sin(", num2str(j*2*pi/T0),"*x)",aux_car);
  endfor
endfor
function plot_k(i,v,y,T0,k,a0)
  u = [-T0/2:T0/2];
  y_periodic = y'*ones(1,length(y));
  y_periodic = (y_periodic(:))';
  subplot (2, 2, i)
  hold on;
  title(sprintf("Serie de Fourier con K = %i",k))
  fplot(inline(strcat(v,"+",num2str(a0/2)),"x"))
  stem(u,y_periodic(1:length(u)), "linewidth",3)
  legend("hide");
  grid;
  hold off;
endfunction
for i=1:length(k)
  plot_k(i,char(f(i)),y,T0,k(i),a0)
endfor
axis("auto")


