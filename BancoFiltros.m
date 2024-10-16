function [janelas_filtros] = BancoFiltros(matrix_dados,canais,dadosAmostra, FrequenciasCorte)
%Banco de filtros de 1 a 5 
    [linhas colunas]= size(matrix_dados);
    janelas_filtros=[];
    frequencia_de_amostragem = dadosAmostra; % Hz
    for i=1:linhas
        canal_com_filtro=[];
        amostra= matrix_dados(i,:);
        for j = 1:length(canais)
            canal=amostra(((j-1)*dadosAmostra)+1:j*dadosAmostra);
            for k= 1:length(FrequenciasCorte)-1
                [fb, fa] = butter(2, [FrequenciasCorte(k) FrequenciasCorte(k+1)] / (frequencia_de_amostragem / 2), 'bandpass');
                filtragem = filter(fb,fa,canal);
                canal_filtro= mean(filtragem);
                canal_com_filtro=[canal_com_filtro,canal_filtro];
            end
        end
        janelas_filtros = [janelas_filtros; canal_com_filtro];
    end
end

