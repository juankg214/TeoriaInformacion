function plot_birz(bits,cod)
  #Graficar Bipolar RZ
  tau = [0:.1:length(bits)];
  brz = zeros(1, length(tau));
  for i = 0:length(bits)-1
    if (bits(i+1) == 1)
      for j = 1:5
        brz((10*i)+j) = 1;
      endfor
    elseif (bits(i+1) == 0)
      for j = 1:5
        brz((10*i)+j) = -1;
      endfor
    endif
  endfor
  subplot(3,2,4); plot(tau,brz); title(['BIPOLAR RZ PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;
endfunction