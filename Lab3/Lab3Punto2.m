P_x = [0.08 0.25 0.20 0.12 0.3 0.05];
#Organiza el arreglo desendentemente 
P_x = sort(P_x,'descend')
Res = Huffman(P_x)


#H(x)
H_x = 0;
for i = 1:length(P_x)
H_x = H_x + P_x(i)*log2(P_x(i));
endfor
H_x = H_x * -1

L = 0;
for i = 1:length(Res)
  L = L + P_x(i)*length(Res(i){:})
endfor
L

n = H_x/L 