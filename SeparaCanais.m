function [dados] = SeparaCanais(eeg_data,freqAmost,tempoFocado,tempoDesfocado,canaisUsados)
    %Esta função é usada para deaparar os canais que foram usados da base
    %de dados selecionada. 
    canais=[];
    for i=1:length(canaisUsados)
        C= eeg_data(:,canaisUsados(i))';     %Separa o vetor de dados do canal 
        C_dtr= detrend(C);                   %Tira a tendência do sinal
        canais= [canais; C_dtr];             %Adiciona o vetor de dados do canal em uma matriz
    end
    
    %Separa a matriz em focada e desfocada 
    focado= canais(:,1:freqAmost*tempoFocado);
    desfocado= canais(:,(freqAmost*tempoFocado)+1:freqAmost*tempoDesfocado);
    dados= [focado; desfocado];
end

