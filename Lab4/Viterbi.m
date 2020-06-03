function [x, d] = Viterbi(c, T, W0, W1)
  
  l = length(c)/2;             % Cantidad de bloques
  
  aux1 = Inf(4,l+1);           % Matriz auxiliar para guardar los valores de las distancias
  aux2 = repmat({""},4,l+1);   % Matriz auxiliar para guardar las posibles cadenas
  aux1(1,1) = 0;
  
  for i = 1:l
    for j = 1:4
      if !isinf(aux1(j,i))
        
        var1 = sum(xor(W0(j,:), c(2*i-1:2*i)));
        var2 = sum(xor(W1(j,:), c(2*i-1:2*i)));
        
        if var1 + aux1(j,i) <= aux1(T(1,j),i+1)
          aux1(T(1,j),i+1) = var1 + aux1(j,i);
          aux2(T(1,j),i+1) = strcat(aux2(j,i),"0");
        endif
        
        if var2 + aux1(j,i) <= aux1(T(2,j),i+1)
          aux1(T(2,j),i+1) = var2 + aux1(j,i);
          aux2(T(2,j),i+1) = strcat(aux2(j,i),"1");
        endif
        
      endif
    endfor
    
    aux1(:,i+1)
    aux2(:,i+1)    
  endfor
  
  [x, ix] = min(aux1(:,l+1))
  d = cell2mat(aux2(ix,l+1));
  
endfunction
