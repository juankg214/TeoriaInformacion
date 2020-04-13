#Definici�n de la funci�n pulso rectangular x(t).
a = 1;
t = [-3:.01:3];
x = (t>-a)&(t<a);
#Definici�n de la transformada X(\omega).
omega = t*100;
X = fft(x);

#Definici�n de H(\omega) (respuesta en frecuencia del filtro).
lim1 = 4;
lim2 = 28;
n = length(X);
H = zeros(1,n);
for i=lim1:lim2
  H(i)=1;
  H(n-i+1)=1;
endfor
H(lim1)=0;
H(lim2+1)=1;

#Producto entre H y X para obtener la se�al filtrada en frecuencia.
Y = H.*X;
#Transformada inversa para hallar la se�al deformada en el tiempo.
y = ifft(Y);

#Gr�ficas de las se�ales x(t), X(\omega), Y(\omega) y y(t).
subplot(2,2,1);plot(t,x,'r');title('Se�al x(t)');
subplot(2,2,2);stem(omega,fftshift(X));axis([-50 50 -200 200]);title('Transformada X(\omega)');
subplot(2,2,4);stem(omega,fftshift(Y));axis([-50 50 -200 200]);title('Se�al filtrada PasaBandas Y(\omega)');
subplot(2,2,3);plot(t,y,'r');title('Se�al deformada y(t)');
