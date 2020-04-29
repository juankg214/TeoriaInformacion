function plot_binrz(bits,cod)
  #Graficar Bipolar NRZ
  tau = [0:.1:length(bits)];
  bnz = zeros(1, length(tau));
  for i = 0:length(bits)-1
    if (bits(i+1) == 1)
      for j = 1:10
        bnz((10*i)+j) = 1;
      endfor
    elseif (bits(i+1) == 0)
      for j = 1:10
        bnz((10*i)+j) = -1;
      endfor
    endif
  endfor
  subplot(3,2,3); plot(tau,bnz); title(['BIPOLAR NRZ PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;
endfunction