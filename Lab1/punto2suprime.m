#Definición de la función pulso rectangular x(t).
a = 1;
t = [-3:.01:3];
x = (t>-a)&(t<a);
#Definición de la transformada X(\omega).
omega = t*100;
X = fft(x);

#Definición de H(\omega) (respuesta en frecuencia del filtro).
lim1 = 6;
lim2 = 30;
n = length(X);
H = ones(1,n);
for i=lim1:lim2
  H(i)=0;
  H(n-i+1)=0;
endfor
H(lim1)=1;
H(lim2+1)=0;

#Producto entre H y X para obtener la señal filtrada en frecuencia.
Y = H.*X;
#Transformada inversa para hallar la señal deformada en el tiempo.
y = ifft(Y);

#Gráficas de las señales x(t), X(\omega), Y(\omega) y y(t).
subplot(2,2,1);plot(t,x,'r');title('Señal x(t)');
subplot(2,2,2);stem(omega,fftshift(X));axis([-50 50 -200 200]);title('Transformada X(\omega)');
subplot(2,2,4);stem(omega,fftshift(Y));axis([-50 50 -200 200]);title('Señal filtrada SuprimeBandas Y(\omega)');
subplot(2,2,3);plot(t,y,'r');title('Señal deformada y(t)');
