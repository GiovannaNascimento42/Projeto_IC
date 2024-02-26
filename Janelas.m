function [janela] = Janelas(focado,desfocado, amostras, dadosAmostra)
%JANELAS Summary of this function goes here
%   Detailed explanation goes here
    janela=[];
    for j=1:amostras 
        canais_focado=[];
        canais_desfocado=[];
        corte1= focado(:, ((j-1)*dadosAmostra)+1:j*dadosAmostra);
        corte2= desfocado(:, ((j-1)*dadosAmostra)+1:j*dadosAmostra);
        for i = 1:7
            canal1=corte1(i,:);
            canais_focado=[canais_focado, canal1];
            canal2=corte2(i,:);
            canais_desfocado=[canais_desfocado, canal2];
        end
        janela = [janela; canais_focado, 1, 0 ; canais_desfocado, 0, 1 ];
    end
end
