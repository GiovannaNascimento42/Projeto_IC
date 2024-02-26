%% Base de dados 
clc
clear

arquivo = "eeg_record";
individuo = 34;                                 %Quantidade de dados 

dataBase_sinal= [];
dataBase_dados= [];
dataBase_classificacao= [];
tempo_focado= 10*60;                            %Início o tempo focado na medição 
tempo_desfocado= 20*60;                         %Inicio do tempo desfocado na medição
CanaisUsados= [5 6 9 10 11 12 15];              %Canais relevantes segundo o artigo 
Amostras = 600;                                 %Quantidade de amostras geradas pelas janelas escolhidas
DadosAmostra = 128;                             %Frequência de amostragem vees o tempo de amostragem

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
    matrix_janelas= Janelas(matrix_dados(1:7,:),matrix_dados(8:14,:),Amostras,DadosAmostra);
    
     % Salvando os dados 
    
    dataBase_sinal= [dataBase_sinal; matrix_janelas];                   % Matrix com todo os dados 
    [linhas colunas]= size(dataBase_sinal);                             % Convertendo o tamanho da matriz para dados
    dataBase_dados= dataBase_sinal(:,1:colunas-2);                      % Matrix com os dados de entrada da RN
    dataBase_classificacao= dataBase_sinal(:,colunas-1:end);            % Matrix com os dados de classificação
end

save('dataBase', 'dataBase_dados','dataBase_classificacao')