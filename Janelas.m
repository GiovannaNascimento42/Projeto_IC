function [janela] = Janelas(canais,focado,desfocado, amostras, dadosAmostra)
    %Esta função converte a matriz de dados recebida em janelas da dimensão
    %definida e reorganiza em colunas de características e linhas de
    %janelas. 
    janela=[];
    for j=1:amostras 
        canais_focado=[];
        canais_desfocado=[];
        corte1= focado(:, ((j-1)*dadosAmostra)+1:j*dadosAmostra);
        corte2= desfocado(:, ((j-1)*dadosAmostra)+1:j*dadosAmostra);
        for i = 1:length(canais)
            canal1=corte1(i,:);
            canais_focado=[canais_focado, canal1];
            canal2=corte2(i,:);
            canais_desfocado=[canais_desfocado, canal2];
        end
        janela = [janela; canais_focado, 1, 0 ; canais_desfocado, 0, 1 ];
    end
end
