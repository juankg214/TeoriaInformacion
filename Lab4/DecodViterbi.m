c = [1 1 0 1 0 0 0 1 1 1];

#Definición del diagrama del codificador
T = [1 3 1 3;      % Matriz de transiciones del diagrama 
     2 4 2 4];    
     
W0 = [0 0;         % Matriz de escritura del diagrama para transiciones 0
      0 1; 
      1 1; 
      1 0];
      
W1 = [1 1;         % Matriz de escritura del diagrama para transiciones 1
      1 0; 
      0 0;
      0 1];   

#Llamada al Algoritmo de Viterbi
[x, d] = Viterbi(c, T, W0, W1);

#Interpretación de la respuesta
e = zeros(1,length(d));
for i = 1:length(d)
  e(i) = str2num(d(i));
endfor

printf(["Cadena original: ", num2str(c), '\n']);
printf(["Cadena decodificada: ", num2str(e), '\n']);
printf(["Numero de errores: ", num2str(x), '\n']);
