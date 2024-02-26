function [dados] = SeparaCanais(eeg_data,freqAmost,tempoFocado,tempoDesfocado,canaisUsados)
    canais=[];
    for i=1:length(canaisUsados)
        C= eeg_data(:,canaisUsados(i))';
        canais= [canais; C];    
    end
    
    focado= canais(:,1:freqAmost*tempoFocado);
    desfocado= canais(:,(freqAmost*tempoFocado)+1:freqAmost*tempoDesfocado);
    dados= [focado; desfocado];
end

