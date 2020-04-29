function plot_k(i,f,y,T0,k,a0)
  u = [-T0/2:T0/2];
  y_periodic = y'*ones(1,length(y));
  y_periodic = (y_periodic(:))';
  subplot (2, 2, i)
  hold on;
  title(sprintf("Serie de Fourier con K = %i",k))
  fplot(inline(strcat(f,"+",num2str(a0/2)),"x"))
  stem(u,y_periodic(1:length(u)), "linewidth",3)
  legend("hide");
  grid;
  hold off;
endfunction