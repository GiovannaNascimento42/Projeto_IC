%% Base de dados 
clc
clear

arquivo = "eeg_record";
individuo = 34;                                 %Quantidade de dados 

dataBase_sinal= [];
dataBase_dados= [];
dataBase_classificacao= [];
tempo_focado= 10*60;                            %Fim o tempo focado na medição 
tempo_desfocado= 20*60;                         %Fim do tempo desfocado na medição
CanaisUsados= [5 6 9 10 11 12 15];              %Canais relevantes segundo o artigo 
Amostras = 600;                                 %Quantidade de amostras geradas pelas janelas escolhidas
DadosAmostra = 128;                             %Frequência de amostragem vees o tempo de amostragem
FrequenciasCorte= [1 5 10 15];                  %Frequência de corte para o banco de filtros
for i=1:individuo
    n_individuos = int2str(i);
    arquivo_i = arquivo + n_individuos;
    disp(arquivo_i)
    
    load(arquivo_i)
    
    freq_amostragem = o.sampFreq;                                  % Frequência de amostragem
    
    eeg_data= o.data(:,:);                                         % Dados dos canais 
    tempo = o.data(:,21);                                          % Vetor de tempo
    tempo = linspace(tempo(1),tempo(end),length(tempo));           % Vetor de tempo otimizado
    
    % Divisão dos canais (verificar função)
    matrix_dados= SeparaCanais(eeg_data,freq_amostragem,tempo_focado,tempo_desfocado,CanaisUsados);
    
    %janelas (verificar função)
    matrix_janelas= Janelas(CanaisUsados,matrix_dados(1:7,:),matrix_dados(8:14,:),Amostras,DadosAmostra);
    
    %Valores RMS (verificar função)
    dados_rms= RMS(matrix_janelas,CanaisUsados,DadosAmostra);
    
    %Valores Banco de Filtros (verificar função)
    dados_filtros= BancoFiltros(matrix_janelas,CanaisUsados,DadosAmostra,FrequenciasCorte);
    
    %Valores picos (verificar função)
    dados_picos= Picos(matrix_janelas,CanaisUsados,DadosAmostra);
    
    %janelas com RMS
    AmostrasRmsPicos= [matrix_janelas(:,1:end-2), dados_rms,dados_picos, matrix_janelas(:,end-1:end)];

    %janelas com filtros
    AmostrasCompletas= [matrix_janelas(:,1:end-2), dados_rms,dados_picos,dados_filtros, matrix_janelas(:,end-1:end)];
    
     % Salvando os dados 
    
    dataBase_sinal= [dataBase_sinal; AmostrasCompletas];                % Matriz com todo os dados 
    [linhas colunas]= size(dataBase_sinal);                             % Convertendo o tamanho da matriz para dados
    dataBase_dados= dataBase_sinal(:,1:colunas-2);                      % Matriz com os dados de entrada da RN
    dataBase_classificacao= dataBase_sinal(:,colunas-1:end);            % Matriz com os dados de classificação
end

dataBase_sinal= dataBase_sinal(:,1:colunas-1);
save('dataBase', 'dataBase_dados','dataBase_classificacao','dataBase_sinal')

