function [janelas_picos] = Picos(matrix_dados,canais,dadosAmostra)
%Picos 
    [linhas colunas]= size(matrix_dados);
    janelas_picos=[];
    for i=1:linhas
        canal_picos=[];
        amostra= matrix_dados(i,:);
        for j = 1:length(canais)
            canal=amostra(((j-1)*dadosAmostra)+1:j*dadosAmostra);
            pico= max(canal)-min(canal);
            canal_picos=[canal_picos,pico];
        end
        janelas_picos = [janelas_picos; canal_picos];
    end
end

