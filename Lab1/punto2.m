#Definición de la función pulso rectangular x(t).
a = 1;
t = [-3:.01:3];
x = (t>-a)&(t<a);
#Definición de la transformada X(\omega).
omega = t*100;
X = fft(x);
sa=inline('(sin(x)+(x==0))./(x+(x==0))','x'); 	% Genera la función sa(x)=sin(x)/x
#Transformada inversa para hallar la señal deformada en el tiempo.
y = ifft(X);

#Gráficas de las señales x(t), X(\omega), Y(\omega) y y(t).
subplot(2,2,1);plot(t,x,'r');title('Pulso Rectangular');
subplot(2,2,2);stem(omega,fftshift(X));axis([-50 50 -200 200]);title('FFT del Pulso Rectangular');
omega1 = [-6*pi:0.01:6*pi];
subplot(2,2,4);plot(omega1,2*a*sa(a*omega1),'-r');xlabel('\omega'); ylabel('FFT del Pulso Rectangular'); title('Transformada de Fourier del Pulso Rectangular Analitica'); grid;
subplot(2,2,3);plot(t,y,'r');title('FFT : Transformada de Fourier del Pulso Rectangular');
