close all
clc

k=[1 5 10 20]; 
y=[1 1 -1 1];  %Señal Cuadrada
T0 = length(y); 
l = Detect_integrals_intervals(y); %Se detecta los intervalos de las integrales
number_of_intervals = length(l); %Se calcula el numero de integrales a realizar por el numero de intervalos
a0 = 0; 
pointer = 0; %Apuntador al vector y 
limite_inferior = -T0/2;
limite_superior = -T0/2;

for i=1:number_of_intervals
  pointer += l(i); %Se actualiza el apuntador para cada intervalo
  f = @(x) y(pointer); 
  limite_superior += l(i); %Aumenta el limite superior de acuerdo al numero de elementos en el intervalo
  a0 += 2/T0.*quad(f,limite_inferior,limite_superior); %Se calcula la integral
  limite_inferior = limite_superior; 
endfor

f = [" ";" ";" ";" "]; %Donde se va a guardar la serie de fourier para cada k
f = cellstr(f); 

for z=1:length(k) %Se calculara la funcion para distintos valores de N.
  for j=1:k(z) %Sumatoria
      an = 0; bn = 0; pointer=0; limite_inferior=-T0/2; limite_superior=-T0/2;
    for i=1:number_of_intervals %Calcular an,bn
      pointer += l(i);
      f1 = @(x) y(pointer)*cos(j*2*pi/T0*x);
      f2 = @(x) y(pointer)*sin(j*2*pi/T0*x);
      limite_superior += l(i);
      an += 2/T0*quad(f1,limite_inferior,limite_superior);
      bn += 2/T0*quad(f2,limite_inferior,limite_superior);
      limite_inferior = limite_superior;
    endfor
   aux_car = "+"; %Para poder concatenar la proxima funcion.
   if(j==k(z))
    aux_car = ""; %No hay necesidad si no se va a concatenar mas
   endif 
    %Se concatena la funcion.
    f(z) =  strcat(f(z),num2str(an),"*cos(", num2str(j*2*pi/T0),"*x)+", num2str(bn) ,"*sin(", num2str(j*2*pi/T0),"*x)",aux_car);
  endfor
endfor
%Se Grafican las funciones
for i=1:length(k)
  plot_k(i,char(f(i)),y,T0,k(i),a0)
endfor
axis("auto")


