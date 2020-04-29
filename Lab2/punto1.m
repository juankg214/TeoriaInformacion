close all
clc

#Definición de los tiempos y Señal
lim1 = -pi;                           %Limites 
lim2 = pi;      
At = .01;                 
t = [lim1:At:lim2];                   %Tiempos en los limites   
fm = 2;                               %Frecuencia Maxima
m =  sin(2*pi*t) + 2*sin(2*pi*fm*t);  %Señal

figure(1);
#Señal Original Grafica
subplot(4,1,1); 
plot(t,m,'b');
grid; 
title('Señal original m(t)');
xlabel("t"),ylabel("m(t)");                               
  

#------------------- Muestreo -------------------------------
Ts = 1/(2*fm);                        %Tiempo muestral 
d_Ts = [lim1:Ts:lim2];                %Vector de tiempos para muestreo
p = Ts/At;                            %Espacio entre una muestra y la siguiente

ms = ones(1,length(d_Ts));
for i = 0:length(ms)-1
  ms(i+1) = m((i*p)+1);               %Se escogen los puntos de la señal original en cada Tiempo muestral
endfor


#Señal Muestrada
subplot(4,1,2);
hold on;
stem(d_Ts,ms,'b'); 
plot(t,m,'b');
grid; 
title('Señal Muestreada ms(t)');
xlabel("t"),ylabel("m(t)");
hold off;

#---------- Cuantificación ----------

mp = max(m);           % Amplitud maxima. En nuestro ejemplo 2.7358
n = 2;                 % Número de bits por muestra
L = 2^n;               % Número de niveles
w = 2*mp/L;            % Ancho (width) de cada nivel. En nuestro ejemplo ejemplo 1.3679

l_ms = length(ms);     % Numero de puntos de muestreo
fr = zeros(1,l_ms);    % Franjas en las que cae cada muestra, Valores de fr(j) = -4:-1
q = zeros(1,l_ms);     % Señal Cuantificada en cada franja, cada franja tendra un valor de -w-w/2, -w+w/2, w+w/2, w-w/2
for j = 1:l_ms;
  fr(j) = floor((ms(j)-mp)/w);
  q(j) = mp + w/2 + fr(j)*w
endfor
fr = (L.+fr)            % Toma valores de 0:3

#Señal Cuantificada
subplot(4,1,3); 
hold on;
plot(t,m,'b');
stem(d_Ts, q,'b'); 
grid; 
title(['Señal Cuantizada en ' num2str(L) ' niveles']);
hold off;
#------------------- demodulacion -------------------------------
dem = ones(1,length(d_Ts));
for i = 0:length(ms)-2
  dem(i+1) = (ms(i+1)-ms(i+2)/2);            %Se escogen los puntos de la señal original en cada Tiempo muestral
endfor
subplot(4,1,4); 
stem(d_Ts,dem,'b');
grid; 
title('Señal original m(t)');
xlabel("t"),ylabel("m(t)"); 


#---------- CODIFICACÓN ----------

#Transformación del vector de franjas 
#en un único string de números binarios 
cod = '';
for j = 1:length(fr)
  cod = strcat(cod,dec2bin(fr(j),n));
endfor
#Creación de un vector de bits a partir del string binario 
bits = ones(1,length(cod));
for i = 1:length(cod)
  bits(i) = bits(i)*str2num(cod(i));
endfor


#---------- SEÑALIZACIÓN ----------
figure(2);
tau = [0:.1:length(bits)];

#Unipolar NRZ
unz = zeros(1, length(tau));
for i = 0:length(bits)-1
  if (bits(i+1) == 1)
    for j = 1:10
      unz((10*i)+j) = 1;
    endfor
  endif
endfor
subplot(3,2,1); plot(tau,unz); title(['UNIPOLAR NRZ PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;

#Unipolar RZ
urz = zeros(1, length(tau));
for i = 0:length(bits)-1
  if (bits(i+1) == 1)
    for j = 1:5
      urz((10*i)+j) = 1;
    endfor
  endif
endfor
subplot(3,2,2); plot(tau,urz); title(['UNIPOLAR RZ PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;

#Bipolar NRZ
bnz = zeros(1, length(tau));
for i = 0:length(bits)-1
  if (bits(i+1) == 1)
    for j = 1:10
      bnz((10*i)+j) = 1;
    endfor
  elseif (bits(i+1) == 0)
    for j = 1:10
      bnz((10*i)+j) = -1;
    endfor
  endif
endfor
subplot(3,2,3); plot(tau,bnz); title(['BIPOLAR NRZ PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;

#Bipolar RZ
brz = zeros(1, length(tau));
for i = 0:length(bits)-1
  if (bits(i+1) == 1)
    for j = 1:5
      brz((10*i)+j) = 1;
    endfor
  elseif (bits(i+1) == 0)
    for j = 1:5
      brz((10*i)+j) = -1;
    endfor
  endif
endfor
subplot(3,2,4); plot(tau,brz); title(['BIPOLAR RZ PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;

#AMI
ami = zeros(1, length(tau));
ami_b = 1;
for i = 0:length(bits)-1
  if (bits(i+1)==1 && ami_b==1)
    for j = 1:5
      ami((10*i)+j) = ami_b;
    endfor
    ami_b = -1;
  elseif (bits(i+1)==1 && ami_b==-1)
    for j = 1:5
      ami((10*i)+j) = ami_b;
    endfor
    ami_b = 1;
  endif
endfor
subplot(3,2,5); plot(tau,ami); title(['AMI RZ PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;

#Manchester
man = zeros(1, length(tau));
for i = 0:length(bits)-1
  if (bits(i+1) == 1)
    for j = 1:5
      man((10*i)+j) = 1;
    endfor
    for j = 6:10
      man((10*i)+j) = -1;
    endfor
  elseif (bits(i+1) == 0)
    for j = 1:5
      man((10*i)+j) = -1;
    endfor
    for j = 6:10
      man((10*i)+j) = 1;
    endfor
  endif
endfor
subplot(3,2,6); plot(tau,man); title(['MANCHESTER PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;

