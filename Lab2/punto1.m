close all
clc

#Definici�n de los tiempos y Se�al
lim1 = -pi;                           %Limites 
lim2 = pi;      
At = .01;                 
t = [lim1:At:lim2];                   %Tiempos en los limites   
fm = 2;                               %Frecuencia Maxima
m =  sin(2*pi*t) + 2*sin(2*pi*fm*t);  %Se�al


#Se�al Original Grafica
figure(1);
subplot(4,1,1); 
plot(t,m,'b');
grid; 
title('Se�al original m(t)');
xlabel("t"),ylabel("m(t)");                               
  

#------------------- Muestreo -------------------------------
Ts = 1/(2*fm);                        %Tiempo muestral 
v_Ts = [lim1:Ts:lim2];                %Vector de tiempos para muestreo
delta = Ts/At;                        %Espacio entre una muestra y la siguiente

ms = ones(1,length(v_Ts));
for i = 0:length(ms)-1
  ms(i+1) = m((i*delta)+1);           %Se escogen los puntos de la se�al original en cada Tiempo muestral
endfor


#Se�al Muestrada
subplot(4,1,2);
hold on;
stem(v_Ts,ms,'b'); 
plot(t,m,'b');
grid; 
title('Se�al Muestreada ms(t)');
xlabel("t"),ylabel("m(t)");
hold off;
                            
  
#---------- Cuantificaci�n ----------

mp = max(m);           % Amplitud maxima. En nuestro ejemplo 2.7358
n = 2;                 % N�mero de bits por muestra
L = 2^n;               % N�mero de niveles
w = 2*mp/L;            % Ancho de cada nivel. En nuestro ejemplo ejemplo 1.3679

l_ms = length(ms);     % Numero de puntos de muestreo
lv = zeros(1,l_ms);    % Franjas en las que cae cada muestra, Valores de fr(j) = -4:-1
quanti = zeros(1,l_ms);     % Se�al Cuantificada en cada franja, cada franja tendra un valor de -w-w/2, -w+w/2, w+w/2, w-w/2
for j = 1:l_ms;
  lv(j) = floor((ms(j)-mp)/w);
  quanti(j) = mp + w/2 + lv(j)*w
endfor
lv = (L.+lv)            % Toma valores de 0:3

#Se�al Cuantificada
subplot(4,1,3); 
hold on;
plot(t,m,'b');
stem(v_Ts, quanti,'b'); 
grid; 
title(['Se�al Cuantificada en ' num2str(L) ' niveles']);
hold off;
#---------- Demodulation -------
f = "";
aux = num2str(2*pi*fm);
##for i=1:length(ms)-1
##  if(i!=length(ms)-1)
##    f = strcat(f,num2str(ms(i)),".*sin(",aux,"*(t.-",num2str(Ts*i),"))./(",aux,"*(t.-",num2str(Ts*i),")).+");
##   else
##    f = strcat(f,num2str(ms(i)),".*sin(",aux,"*(t.-",num2str(Ts*i),"))./(",aux,"*(t.-",num2str(Ts*i),"))");
##   endif
##endfor

for i=1:length(ms)-1
  if(i!=length(ms)-1)
    f = strcat(f,num2str(ms(i)),".*sinc((t.-",num2str(i*Ts),")./",num2str(Ts),").+");
   else
    f = strcat(f,num2str(ms(i)),".*sinc((t.-",num2str(i*Ts),")./",num2str(Ts),")");
   endif
endfor
subplot(4,1,4); 
f = inline(f,"t");
f(1)
fplot(f,[0 , 7],'b');
legend("off");
grid; 
title('Se�al Demodulada');
xlabel("t"),ylabel("m(t)");   


#---------- CODIFICAC�N ----------
cod = '';
for j = 1:length(lv)                    %Primero se convierte a binario y se pasa a un string
  cod = strcat(cod,dec2bin(lv(j),n));
endfor
bits = ones(1,length(cod));             %Luego se crea el vector a partir del string.
for i = 1:length(cod)
  bits(i) = bits(i)*str2num(cod(i));
endfor


#---------- SE�ALIZACI�N ----------
figure(2);
tau = [0:.1:length(bits)];

plot_uninrz(bits,cod);
plot_unirz(bits,cod);
plot_binrz(bits,cod);
plot_birz(bits,cod);
plot_ami(bits,cod);
plot_manchester(bits,cod);




