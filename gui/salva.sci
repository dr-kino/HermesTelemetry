function salva(h,tempo,pot1,pot2,pot3,pot4,pot5,V,alfa,Beta,i,flag)
    
    closeserial(h);
    dt=getdate();
    str_dia=msprintf('%02d',dt(6));
    str_mes=msprintf('%02d',dt(2));
    str_ano=msprintf('%02d',dt(1));
    str_arq='./dados_'+str_dia+' '+str_mes+' '+str_ano+'.txt';
    fd=mopen(str_arq,'a');
    
    mfprintf(fd,'================================\n');
    mfprintf(fd,'%02d/%02d/%4d  %02dh%02dm%02ds\n',dt(6),dt(2),dt(1),dt(7),dt(8),dt(9));
    mfprintf(fd,'================================\n');
    
    for j=2:i-1
        mfprintf(fd,'%16.3f %16.2f %16.2f %16.2f %16.2f %16.2f\n',tempo(j),pot1(j),pot2(j),pot3(j),pot4(j),pot5(j));
    end
    
    mclose(fd);
    
    soma1=0
    soma2=0
    for j=1:i-1
        if flag(i)==1 then      //scilab coletou dados, mas eram inuteis
            soma1=soma1+1
        elseif flag(i)==2 then  //scilab nao coletou dados novos
            soma2=soma2+1
        end
    end
    
    //imprime estatisticas
    dt=max(tempo)-min(tempo);
    mprintf('Tempo total de aquisicao: %f\n',dt);
    mprintf('Numero total de pontos coletados: %d\n',i);
    mprintf('Numero de pontos perdidos (lixo): %d\n',soma1);
    mprintf('Frequencia media de aquisiçao scilab (Hz): %d\n',i/dt);
    mprintf('Frequencia media de transmissao (Hz): %d\n',(i-soma1-soma2)/dt);
    
endfunction
