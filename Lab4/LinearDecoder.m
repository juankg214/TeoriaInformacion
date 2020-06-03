function d = LinearDecoder(r)
  
  if length(r) != 6
    error("El decodificador solo recibe bloques de 6 bits.");
  endif 

  P = [1 0 1 ; 1 1 1 ; 1 1 0];    %Matriz dada por las ecuaciones del codificador
  I_m = eye(3);                   %Matriz identidad de tamaño mxm
  H = [P I_m];                    %Matriz de chequeo de paridad
  H_T = H';
  
  #Decodificación de síndrome de r
  s = rem(r*H_T,2);
  if sum(s) == 0
    d = r(1:3);
  else
    e = zeros(1,6);
    for i = 1:6
      if isequal(s, H_T(i,:))
        e(i) = 1;
      endif
    endfor
    e
    r = xor(r,e)
    d = r(1:3);
  endif
  
endfunction