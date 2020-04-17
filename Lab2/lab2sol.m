#Definici�n de los tiempos
lim1 = -3; lim2 = 3;      % Para dibujar la se�al entre lim1 y lim2
At = .01;                 % Espacio entre tiempos
t = [lim1:At:lim2];       % Vector de tiempos

#Se�al a enviar
m = 2*sin(t) + sin(2*t);    % Definici�n de la se�al m(t)
A = max(m);                 % Amplitud m�xima de la se�al
fm = 2;                     % Frecuencia m�xima de la se�aal


#------------ MUESTREO ------------

#C�lculo del tiempo entre muestras
Ts = 1/(2*fm);            % Tiempo muestral seg�n Teorema del Muestreo
d_Ts = [lim1:Ts:lim2];    % Vector de tiempos de muestreo
p = Ts/At;                % Espacio entre una muestra y la siguiente

#Definici�n de la se�al muestreada m_s(t)
m_s = ones(1,length(d_Ts));
for i = 0:length(m_s)-1
  m_s(i+1) = m((i*p)+1);
endfor

#Gr�fica de las se�ales m(t) y m_s(t)
figure(1);
subplot(3,1,1); plot(t,m,'b'); grid; title('Se�al original m(t)');
subplot(3,1,2); stem(d_Ts,m_s,'b'); grid; title('Se�al Muestreada m_S(t)');


#---------- CUANTIZACI�N ----------

#Definici�n de los niveles de cuantizaci�n
n = 2;                % N�mero de bits por muestra
L = 2^n;              % N�mero de niveles
w = 2*A/L;            % Ancho (width) de cada nivel

#C�lculo de la se�al cuantizada
fr = zeros(1,length(m_s));    % Franjas en las que cae cada muestra
q = zeros(1,length(m_s));     % Se�al cuantizada
for j = 1:length(m_s);
  fr(j) = floor((m_s(j)-A)/w);
  q(j) = A + w/2 + fr(j)*w;
endfor
fr = (L.+fr);

#Gr�fica de las se�ales muestreada y cuantizada
subplot(3,1,3); stem(d_Ts, q,'b'); grid; title(['Se�al Cuantizada en ' num2str(L) ' niveles']);


#---------- CODIFICAC�N ----------

#Transformaci�n del vector de franjas 
#en un �nico string de n�meros binarios 
cod = '';
for j = 1:length(fr)
  cod = strcat(cod,dec2bin(fr(j),n));
endfor

#Creaci�n de un vector de bits a partir del string binario 
bits = ones(1,length(cod));
for i = 1:length(cod)
  bits(i) = bits(i)*str2num(cod(i));
endfor


#---------- SE�ALIZACI�N ----------
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

