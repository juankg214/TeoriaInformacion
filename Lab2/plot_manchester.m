function plot_manchester(bits,cod)
  #Graficar Manchester
  tau = [0:.1:length(bits)];
  man = zeros(1, length(tau));
  for i = 0:length(bits)-1
    if (bits(i+1) == 1)
      for j = 1:5
        man((10*i)+j) = 1;
      endfor
      for j = 6:10
        man((10*i)+j) = -1;
      endfor
    elseif (bits(i+1) == 0)
      for j = 1:5
        man((10*i)+j) = -1;
      endfor
      for j = 6:10
        man((10*i)+j) = 1;
      endfor
    endif
  endfor
  subplot(3,2,6); plot(tau,man); title(['MANCHESTER PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;
endfunction