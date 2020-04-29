function plot_ami(bits,cod)
  #Graficar AMI RZ
  tau = [0:.1:length(bits)];
  ami = zeros(1, length(tau));
  ami_b = 1;
  for i = 0:length(bits)-1
    if (bits(i+1)==1 && ami_b==1)
      for j = 1:5
        ami((10*i)+j) = ami_b;
      endfor
      ami_b = -1;
    elseif (bits(i+1)==1 && ami_b==-1)
      for j = 1:5
        ami((10*i)+j) = ami_b;
      endfor
      ami_b = 1;
    endif
  endfor
  subplot(3,2,5); plot(tau,ami); title(['AMI RZ PARA ' cod]); axis([0 length(bits) -1.1 1.1]); grid minor;
endfunction