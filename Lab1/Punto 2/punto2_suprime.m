#Definici�n de la funci�n pulso rectangular x(t).
Fs=100;
a = 1;
t = [-3:1/Fs:3];
x = (t>-a)&(t<a);
#Definici�n de la transformada X(\omega).
omega = t*100;
X = fft(x);

#Definici�n de H(\omega)
wc1 = 6;
wc2 = 30;
n = length(X);
H = ones(1,n);
for i=wc1:wc2
  H(i)=0;
  H(n-i+1)=0;
endfor
H(wc1)=1;
H(wc2+1)=0;

#Producto entre H y X para obtener la se�al filtrada en frecuencia.
Y = H.*X;
#Transformada inversa para hallar la se�al deformada en el tiempo.
y = ifft(Y);

#Gr�ficas de las se�ales x(t), X(\omega), Y(\omega) y y(t).
plot_4(t,x,y,omega,X,Y,'Se�al Filtrada suprime banda ideal Y(\omega)');
