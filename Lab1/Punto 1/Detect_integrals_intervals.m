function l = Detect_integrals_intervals(x)
  %Funcion que dado un array, devuelve un array con el numero de intervalos 
  %Consecutivos de cada elemento.
  % Ejemplo: [1 1 1 0 0 1 0 1 1 ] -> [3 2 1 1 2]   
  l = [];
  contador = 1;
  for i = 1:length(x)
    if(i==1)
      aux = x(i);    
     else
      if(aux != x(i))
        l(end+1) = contador;
        aux = x(i);
        contador = 1;
       else
        contador++;
       endif
      endif
  endfor
  l(end+1) = contador;
endfunction