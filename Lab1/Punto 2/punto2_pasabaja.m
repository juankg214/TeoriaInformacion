#Definici�n de la funci�n pulso rectangular x(t).
Fs=100;
a = 1;
t = [-3:1/Fs:3];
x = (t>-a)&(t<a);
#Definici�n de la transformada X(\omega).
omega = t*100;
X = fft(x);

#Definici�n de H(\omega)
wc = 10; #Entre mas cercano a Fs/2, el filtro tendra menos efecto
n = length(X);
H = zeros(1,n);
for i=1:wc
  H(i)=1;
  H(n-i+1)=1;
endfor
H(wc+1)=1;

#Producto entre H y X para obtener la se�al filtrada en frecuencia.
Y = H.*X;
#Transformada inversa para hallar la se�al deformada en el tiempo.
y = ifft(Y);

#Gr�ficas de las se�ales x(t), X(\omega), Y(\omega) y y(t).
plot_4(t,x,y,omega,X,Y,'Se�al Filtrada PasaBajas ideal Y(\omega)');
