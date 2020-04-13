%Dada una señal periódica x(t) con periodo t0, un vector de tiempos t
%y un vector de máximo cuatro valores de truncamiento N, grafica la
%señal x(t) y la aproximación mediante series de Fourier trigonométricas
%para cada valor N de truncamiento.
function plotsftt (x_t, t0, t, N)
  % Entrada - x_t: string que define la señal x(t)
  %         - t0: periodo de la señal x(t)
  %         - t : tiempos sobre los que se calcula x(t) y x_N(t)
  %         - N: vector de valores de truncamiento

  x_f = inline(x_t, 't');
  t_p = t - t0*floor(t/t0);
  x = x_f(t_p);
  n = length(N); 

  if ( n == 1 )
    plot(t,x,'-k', t,sftt(x_t,t0,N(1),t),'-r'); 
    legend(['x(t)'],['x_N(t), N = ' num2str(N(1))]); xlabel('t'); ylabel('x');
  elseif ( n == 2 )
    subplot(1,2,1);  
    plot(t,x,'-k', t,sftt(x_t,t0,N(1),t),'-r');
    legend(['x(t)'],['x_N(t), N = ' num2str(N(1))]); xlabel('t'); ylabel('x');
    subplot(1,2,2);  
    plot(t,x,'-k', t,sftt(x_t,t0,N(2),t),'-b');
    legend(['x(t)'],['x_N(t), N = ' num2str(N(2))]); xlabel('t'); ylabel('x');
  elseif ( n == 3 )
    subplot(2,2,1);  
    plot(t,x,'-k', t,sftt(x_t,t0,N(1),t),'-r'); 
    legend(['x(t)'],['x_N(t), N = ' num2str(N(1))]); xlabel('t'); ylabel('x'); 
    subplot(2,2,2);  
    plot(t,x,'-k', t,sftt(x_t,t0,N(2),t),'-b');
    legend(['x(t)'],['x_N(t), N = ' num2str(N(2))]); xlabel('t'); ylabel('x');
    subplot(2,2,3);  
    plot(t,x,'-k', t,sftt(x_t,t0,N(3),t),'-g');
    legend(['x(t)'],['x_N(t), N = ' num2str(N(3))]); xlabel('t'); ylabel('x');
  elseif ( n == 4 )
    subplot(2,2,1);  
    plot(t,x,'-k', t,sftt(x_t,t0,N(1),t),'-r');
    legend(['x(t)'],['x_N(t), N = ' num2str(N(1))]); xlabel('t'); ylabel('x');  
    subplot(2,2,2);  
    plot(t,x,'-k', t,sftt(x_t,t0,N(2),t),'-b'); 
    legend(['x(t)'],['x_N(t), N = ' num2str(N(2))]); xlabel('t'); ylabel('x');   
    subplot(2,2,3);  
    plot(t,x,'-k', t,sftt(x_t,t0,N(3),t),'-g');
    legend(['x(t)'],['x_N(t), N = ' num2str(N(3))]); xlabel('t'); ylabel('x');    
    subplot(2,2,4);  
    plot(t,x,'-k', t,sftt(x_t,t0,N(4),t),'-m');
    legend(['x(t)'],['x_N(t), N = ' num2str(N(4))]); xlabel('t'); ylabel('x');
  else
    error ("La cantidad de valores de truncamiento debe ser menor o igual a 4.");
  endif    
  
endfunction
