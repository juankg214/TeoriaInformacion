function y = Huffman(P_x) 
  if length(P_x) == 2
    y = {'0' '1'};
    return 
  endif
  
  #Se crea una matriz auxiliar, donde se guarda la nueva matriz con un elemento menos
  aux = P_x(1:(length(P_x)-1));
  aux(length(aux)) = P_x(length(P_x)-1) + P_x(length(P_x));
  
  
  #Organiza el vector (con Bubble sort) solo se itera con el ultimo elemento,
  # ya que es el unico que puede estar desordenado
  ind = length(aux);
  while (ind > 1 && aux(ind-1) < aux(ind))
    val = aux(ind-1);
    aux(ind-1) = aux(ind);
    aux(ind) = val;
    ind --;
  endwhile
  #El valor de ind nos indica en que posicion queda la suma de los ultimos dos valores
  code = Huffman(aux);
  
  #Se mueve el valor codificado de la suma a la posicion final del vector
  while ind < length(code)
    val = code(ind);
    code(ind) = code(ind+1);
    code(ind+1) = val;
    ind++;
  endwhile
 
  code((ind+1))= strcat(code(ind),'1');
  code(ind) = strcat(code(ind),'0');
  
  
  y = code;
  return 
   
endfunction