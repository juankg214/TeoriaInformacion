%Dados una se�al peri�dica x(t) y un par�metro de truncamiento N, calcula
%la aproximaci�n a x(t) mediante series de Fourier trigonom�tricas.
function xnt = sftt (x_t, t0, N, t)
  % Entrada - x_t: se�al x(t)
  %         - t0: periodo de la se�al x(t) 
  %         - N: par�metro de truncamiento de la serie
  %         - t: tiempo en el cual se eval�a  
  % Salida  - xnt: se�al truncada hasta N
  
  xnt = a_k(x_t,t0,0)/2; % primer termino   
  w0 = (2*pi)/t0; 
  if ( N != 0 )
    for k = 1:N
      s1 = a_k(x_t, t0, k) * cos(k*w0.*t);
      s2 = b_k(x_t, t0, k) * sin(k*w0.*t);
      s = s1 + s2;
      xnt = xnt + s;
    endfor
  endif
  return;
  
endfunction

% Dados x(t) y un valor k, calcula el coeficiente a_k.
function a = a_k (x_t, t0, k)
  % Entrada - x_t: se�al x(t)
  %         - t0: periodo de la se�al x(t)
  %         - k: sub�ndice del coeficiente a_k         
  % Salida  - a: valor del coeficiente a_k
  
  w0 = (2*pi)/t0;
  z_s = ['cos(' num2str(k*w0) '*t)']; % num2str convierte k*w0 a una string
  z = inline([x_t '*' z_s], 't');
  a = (2/t0) * quad(z,0,t0); % quad calcula la integral de x(t)cos(kw0t)dt  desde 0 hasta t0
  
endfunction

% Dados x(t) y un valor k, calcula el coeficiente b_k.
function b = b_k (x_t, t0, k)
  % Entrada - x_t: se�al x(t)
  %         - t0: periodo de la se�al x(t)
  %         - k: sub�ndice del coeficiente b_k 
  % Salida  - b: valor del coeficiente b_k
  
  w0 = (2*pi)/t0;
  z_s = ['sin(' num2str(k*w0) '*t)'];
  z = inline([x_t '*' z_s], 't');
  b = (2/t0) * quad(z,0,t0);
  
endfunction
