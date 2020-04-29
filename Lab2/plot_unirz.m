function plot_unirz(bits,cod)
  #Graficar Unipolar RZ
  tau = [0:.1:length(bits)];  
  urz = zeros(1, length(tau));
  for i = 0:length(bits)-1
    if (bits(i+1) == 1)
      for j = 1:5
        urz((10*i)+j) = 1;
      endfor
    endif
  endfor
  subplot(3,2,2); plot(tau,urz); title(['UNIPOLAR RZ PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;
endfunction