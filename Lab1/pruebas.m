#Se�al Diente de sierra
plotsftt('t', 1, [0:.01:3], [3 6 9 12])
#Se�al 'Sillas' peri�dicas
plotsftt('rem(floor(t),3)', 3, [0:.02:7], [4 8 12 16])
#Fen�meno de Gibbs
plotsftt('rem(floor(t),2)', 2, [0:.01:2], [10 100])
#Pulso cuadrado peri�dico
plotsftt('rem(floor(t),2)', 2, [0:.01:5], [4 8 12 16])
#Se�al triangular
plotsftt('abs(t-1)', 2, [-1:.02:5], [2 4 6 8])

