#P(x) 
P_x = [0.5 0.5]

#P(y|x)
P_yx = [0.5 0.5; 0.5 0.5]

#P(y)
P_y = P_x*P_yx

#P(x,y)
P_x_d = diag(P_x);
P_x_y = P_x_d * P_yx

#H(x)
H_x = 0;
for i = 1:length(P_x)
H_x = H_x + P_x(i)*log2(P_x(i));
endfor
H_x = H_x * -1

# H(y|x)
H_yx = 0;
tam = size(P_x_y);
for j = 1:tam(1)
  for i = 1:tam(2)
    H_yx = H_yx + P_x_y(i,j)*log2(P_yx(j,i));
  endfor
endfor
H_yx = H_yx * -1

#H(y)
H_y = 0;
for i = 1:length(P_y)
  H_y = H_y + P_y(i)*log2(P_y(i));
endfor
H_y = H_y * -1

#H(x,y) = H(y|x) + H(x)
H_x_y = H_yx + H_x

#H(x|y) = H(x,y) - H(y)
H_xy = H_x_y - H_y;

#I(x;y) = H(x) - H(x|y)
I_x_y = H_x - H_xy

#Calcula Cs cuando es un canal binario simetrico
if length(P_x) == 2
  if P_yx(1,2) == P_yx(2,1)
    #Calcula I(x;y) para un canal binario simetrico
    I_xy = H_y + P_yx(1,2)*log2(P_yx(1,2))+(1-P_yx(1,2))*log2(1-P_yx(1,2))
    Cs = 1 + P_yx(1,2)*log2(P_yx(1,2))+ (1-P_yx(1,2))*log2(1-P_yx(1,2))
  endif
endif

