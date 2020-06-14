#P(x)  probabilidad de ocurrencia
P_x = [0.5 0.5] 

#P(y|x) matriz de transici[on de probabilidades
P_yx = [0.5 0.5; 0.5 0.5]

#P(y), probbilidad de salidas
P_y = P_x*P_yx

#P(x,y), probabilidades conjuntas
P_x_d = diag(P_x); # retorna la diagonal de pX
P_x_y = P_x_d * P_yx

#funciones de entropia
#Entropia condicional y conjunta
#Pag 6, cap 10

#H(x), promedio de incertidumbre del canal de entrada
H_x = 0;
for i = 1:length(P_x)
H_x = H_x + P_x(i)*log2(P_x(i));
endfor
H_x = H_x * -1

# H(y|x), el promedio de incertidumbre del canal de salida dado que X fue transmitido
H_yx = 0;
tam = size(P_x_y);
for j = 1:tam(1)
  for i = 1:tam(2)
    H_yx = H_yx + P_x_y(i,j)*log2(P_yx(j,i));
  endfor
endfor
H_yx = H_yx * -1

#H(y), incertidumbre promedio que queda sobre la entrada del canal 
# después de que se haya observado la salida del canal
H_y = 0;
for i = 1:length(P_y)
  H_y = H_y + P_y(i)*log2(P_y(i));
endfor
H_y = H_y * -1

#H(x,y) = H(y|x) + H(x), incertidumbre promedio del canal de 
# comunicación en su conjunto
H_x_y = H_yx + H_x

#H(x|y) = H(x,y) - H(y), equivoco de X con respecto a y
H_xy = H_x_y - H_y;

#I(x;y) = H(x) - H(x|y), incertidumbre acerca del canal de entrada
# que es resuelta observando el canal de salida
I_x_y = H_x - H_xy

#Calcula Cs cuando es un canal binario simetrico
# simetrico porque la probabilidad de recibir 1 si se envía un 0
# es la misma probabilidad de recibir un 0 si se envía un 1

if length(P_x) == 2
  if P_yx(1,2) == P_yx(2,1)
    #Calcula I(x;y) para un canal binario simetrico
    I_xy = H_y + P_yx(1,2)*log2(P_yx(1,2))+(1-P_yx(1,2))*log2(1-P_yx(1,2))
    Cs = 1 + P_yx(1,2)*log2(P_yx(1,2))+ (1-P_yx(1,2))*log2(1-P_yx(1,2))
  endif
endif

