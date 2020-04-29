#Definición de la función pulso rectangular x(t).
Fs=100;
a = 1;
t = [-3:1/Fs:3];
x = (t>-a)&(t<a);
#Definición de la transformada X(\omega).
omega = t*100;
X = fft(x);

#Definición de H(\omega)
wc = 10; #Entre mas cercano a Fs/2, el filtro tendra menos efecto
n = length(X);
H = zeros(1,n);
for i=1:wc
  H(i)=1;
  H(n-i+1)=1;
endfor
H(wc+1)=1;

#Producto entre H y X para obtener la señal filtrada en frecuencia.
Y = H.*X;
#Transformada inversa para hallar la señal deformada en el tiempo.
y = ifft(Y);

#Gráficas de las señales x(t), X(\omega), Y(\omega) y y(t).
plot_4(t,x,y,omega,X,Y,'Señal Filtrada PasaBajas ideal Y(\omega)');
