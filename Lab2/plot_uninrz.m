function plot_uninrz(bits,cod)
  #Graficar Unipolar NRZ
  tau = [0:.1:length(bits)];
  unz = zeros(1, length(tau));
  for i = 0:length(bits)-1
    if (bits(i+1) == 1)
      for j = 1:10
        unz((10*i)+j) = 1;
      endfor
    endif
  endfor
  subplot(3,2,1); plot(tau,unz); title(['UNIPOLAR NRZ PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;
endfunction