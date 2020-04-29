function plot_4(t,x,y,omega,X,Y,title_filter)
 subplot(2,2,1);plot(t,x,'b');title('Señal Pulso Rectangular x(t)');axis([-3 3 -0.2 1.4]); xlabel('t');ylabel("x(t)");
 subplot(2,2,2);stem(omega,fftshift(X),"r");axis([-50 50 -200 200]);title('Transformada de Fourier X(\omega)'); xlabel('\omega');ylabel('X(\omega)')
 subplot(2,2,4);stem(omega,fftshift(Y),"r");axis([-50 50 -200 200]);title(title_filter);xlabel('\omega');ylabel('X(\omega)');
 subplot(2,2,3);plot(t,y,'b');title('Señal deformada y(t)');xlabel('t');ylabel("x(t)");
endfunction