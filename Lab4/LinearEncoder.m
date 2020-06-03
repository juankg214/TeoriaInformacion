function c = LinearEncoder(d)

  if length(d) != 3
    error("El codificador solo recibe bloques de 3 bits.");
  endif

  P = [1 0 1 ; 1 1 1 ; 1 1 0];    %Matriz dada por las ecuaciones del codificador
  I_k = eye(3);                   %Matriz identidad de tamaño kxk
  G = [I_k P']                   %Matriz generadora
  
  c = rem(d*G,2); 
  
endfunction