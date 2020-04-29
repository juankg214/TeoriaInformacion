#Definicion de pulso rectangular
Fs = 100;
a = 1;
t = -3:1/Fs:3;
s1 = (t>-a)&(t<a);
L = length(s1);
omega = t*Fs;
#Transformada rapida de Fourier
X = fft(s1)/Fs;
#Solucion Analitica
sa=inline('(sin(x))./(x)','x'); 
#Graficas
#Grafica FFT
subplot(1,2,1);
stem(omega,fftshift(X));axis([-20 20 -2.5 2.5]);
title('Transformada Rapida de Fourier FFT');xlabel('\omega');ylabel('X(\omega)');grid;
#Grafica Solucion analitica
omega1 = [-6*pi:1/Fs:6*pi];
subplot(1,2,2);
plot(omega1,2*a*sa(a*omega1),'-r');axis([-20 20 -2.5 2.5]);
title('Transformada de Fourier Analitica'); grid;xlabel('\omega');ylabel('X(\omega)');

