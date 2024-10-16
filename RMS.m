function [janelas_rms] = RMS(matrix_dados,canais,dadosAmostra)
%RMS 
    [linhas colunas]= size(matrix_dados);
    janelas_rms=[];
    for i=1:linhas
        canal_com_rms=[];
        amostra= matrix_dados(i,:);
        for j = 1:length(canais)
            canal=amostra(((j-1)*dadosAmostra)+1:j*dadosAmostra);
            canal_rms= rms(canal);
            canal_com_rms=[canal_com_rms,canal_rms];
        end
        janelas_rms = [janelas_rms; canal_com_rms];
    end
end

