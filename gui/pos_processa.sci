function pos_processa()
    
    //apaga as janelas graficas correntes
    xdel(winsid());
    clear
    clc
    
    exec('escolhe_arquivo.sci',-1);
    
    global bl
    
    //zeros dos potenciometros
    z(1)=18.44;
    z(2)=44.89;
    z(3)=32.64;
    z(4)=19.70;
    z(5)=47.06;
    
    [arq]=escolhe_arquivo('./','.txt','Escolha o arquivo de input');
    
    //divide o nome do arquivo em: 'dados' + 'data' + 'extensao'
    str=strsplit(arq,['_' '.']);
    str2=part(str(2),[1:2])+'/'+part(str(2),[4:5])+'/'+part(str(2),[7:10]);
    //abre o arquivo
    fd=mopen('./'+arq,'r');
    //le todas as linhas
    linha=mgetl(fd,-1);
    //quantidade total de linhas
    nlinhas=size(linha,1);
    //separa os blocos de medicao
    nblocos=0;
    for i=1:nlinhas
        if part(linha(i),[1:10])==str2 then
            nblocos=nblocos+1;  //numero total de blocos
            indi(nblocos)=i+2;  //linha em que comecam os dados do bloco
            //le a hora de termino da aquisicao
            horaf(nblocos,:)=strtod([part(linha(indi(nblocos)-2),[13:14]) part(linha(indi(nblocos)-2),[16:17]) part(linha(indi(nblocos)-2),[19:20])]);
            horaf(nblocos,:)=horaf(nblocos,:)-[3 0 0];
            //le o tempo inicial de aquisicao do bloco
            ti(nblocos)=strtod(part(linha(i+3),[1:16]));
            if nblocos>1 then
                //le o tempo final de aquisicao do bloco
                tf(nblocos-1)=strtod(part(linha(i-2),[1:16]));
                indf(nblocos-1)=i-2;  //linha em que terminam os dados do bloco
            end
        end
    end
    tf(nblocos)=strtod(part(linha(nlinhas-1),[1:16]));
    indf(nblocos)=nlinhas-1;
    
    str_nblocos=string(nblocos);
    
    for i=1:nblocos
    
        dt(i)=tf(i)-ti(i);
        //intervalo de tempo em horas do dia
        //horas
        dh=int(dt(i)/3600);
        //minutos
        dm=int(dt(i)/60)-dh*60;
        //segundos
        ds=int(dt(i)-dm*60-dh*3600);
        
        horai(i,:)=horaf(i,:)-[dh dm ds];
        if horai(i,3)<0 then
            horai(i,3)=horai(i,3)+60;
            horai(i,2)=horai(i,2)-1;
        end
        if horai(i,2)<0 then
            horai(i,2)=horai(i,2)+60;
            horai(i,1)=horai(i,1)-1;
        end
        
        hora_string(i)=string(horai(i,1))+'h'+string(horai(i,2))+'m'+string(horai(i,3))+'s - '+string(horaf(i,1))+'h'+string(horaf(i,2))+'m'+string(horaf(i,3))+'s';
    
    end
    
    t_tot=sum(dt)

    bl=10000
    while bl>nblocos
        //escolhe o bloco a ser plotado
        bl=x_dialog(['Bloco a ser plotado';'1 a '+string(nblocos)],'1');
        bl=evstr(bl)
    end
    
    //le os dados do bloco escolhido
    for i=indi(bl)+1:indf(bl)
        tempo(i-indi(bl))=strtod(part(linha(i),[1:16]));
        pot1(i-indi(bl))=strtod(part(linha(i),[17:33]))-z(1);
        pot2(i-indi(bl))=strtod(part(linha(i),[34:50]))-z(2);
        pot3(i-indi(bl))=(strtod(part(linha(i),[51:67]))-z(3))*-1;
        pot4(i-indi(bl))=strtod(part(linha(i),[68:84]))-z(4);
        pot5(i-indi(bl))=strtod(part(linha(i),[85:101]))-z(5);
    end
    
    //cria figura
    janela=figure(1);
    janela.toolbar_visible='on';
    janela.menubar_visible='off';
    janela.infobar_visible='off';
    janela.background=8;
    janela.figure_position = [-8,-8];
    janela.figure_size = [1382,784];
    a=gca();
    a.data_bounds=[min(tempo),-30;max(tempo),30];
    a.tight_limits='on';
    a.auto_scale='off';
    a.box='on';
    a.grid=[1 1];
    a.thickness=1;
    a.grid_thickness=1;
    a.font_size=3;
    a.title.text=hora_string(bl);
    a.title.font_size=4;
    a.x_label.text='tempo(s)';
    a.x_label.font_size=3;
    a.y_label.text='leitura';
    a.y_label.font_size=3;
    plot(tempo,pot1,'r');
    plot(tempo,pot2,'b');
    plot(tempo,pot3,'k');
    plot(tempo,pot4,'y');
    plot(tempo,pot5,'g');
    
    hl=legend(['LEME';'PD';'PE';'AD';'AE'],4,%f);
    
    //constroi a GUI com botoes para ativar ou desativar curvas
    //cria botoes de interface com usuario
    bot0=uicontrol(janela,'style','checkbox');
    set(bot0,'position',[10 10 150 20]);
    set(bot0,'callback','leme');
    set(bot0,'string','leme');
    set(bot0,'value', 1);
    
    bot1=uicontrol(janela,'style','checkbox');
    set(bot1,'position',[10 30 150 20]);
    set(bot1,'callback','prof_dir');
    set(bot1,'string','prof direito');
    set(bot1,'value', 1);
    
    bot2=uicontrol(janela,'style','checkbox');
    set(bot2,'position',[10 50 150 20]);
    set(bot2,'callback','prof_esq');
    set(bot2,'string','prof esquerdo');
    set(bot2,'value', 1);
    
    bot3=uicontrol(janela,'style','checkbox');
    set(bot3,'position',[10 70 150 20]);
    set(bot3,'callback','ail_dir');
    set(bot3,'string','aileron direito');
    set(bot3,'value', 1);
    
    bot4=uicontrol(janela,'style','checkbox');
    set(bot4,'position',[10 90 150 20]);
    set(bot4,'callback','ail_esq');
    set(bot4,'string','aileron esquerdo');
    set(bot4,'value', 1);
    
    bot5=uicontrol(janela,'style','pushbutton');
    set(bot5,'position',[10 110 150 20]);
    set(bot5,'callback','plot_grafico');
    set(bot5,'string','plotar outro bloco');
    
    close(fd);
    
    t_toth=int(t_tot/3600);
    t_totm=int(t_tot/60)-t_toth*60;
    t_tots=t_tot-t_toth*3600-t_totm*60;
    
    mprintf('\nTempo total de aquisicao do arquivo: %02dh%02dm%02ds\n',t_toth,t_totm,t_tots);
    
    function leme()
        scf(1)
        a=gca();
        b=a.children;
        if b(6).visible=='off' then
            b(6).visible='on';
        else
            b(6).visible='off';
        end
        drawnow();
    endfunction
    
        function prof_dir()
        scf(1)
        a=gca();
        b=a.children;
        if b(5).visible=='off' then
            b(5).visible='on';
        else
            b(5).visible='off';
        end
        drawnow();
    endfunction
    
        function prof_esq()
        scf(1)
        a=gca();
        b=a.children;
        if b(4).visible=='off' then
            b(4).visible='on';
        else
            b(4).visible='off';
        end
        drawnow();
    endfunction
    
        function ail_dir()
        scf(1)
        a=gca();
        b=a.children;
        if b(3).visible=='off' then
            b(3).visible='on';
        else
            b(3).visible='off';
        end
        drawnow();
    endfunction
    
        function ail_esq()
        scf(1)
        a=gca();
        b=a.children;
        if b(2).visible=='off' then
            b(2).visible='on';
        else
            b(2).visible='off';
        end
        drawnow();
    endfunction
    
    function plot_grafico(indi,indf,nblocos,bot0,bot1,bot2,bot3,bot4,linha,z,hora_string)
        
        global bl
        
        bl2=10000
        while bl2>nblocos
            //escolhe o bloco a ser plotado
            bl2=x_dialog(['Bloco a ser plotado';'1 a '+string(nblocos)],'1');
            bl2=evstr(bl2)
        end
        
        if (bl2~=bl) then
            
            bl=bl2
            
            //le a hora de termino da aquisicao
            horaf=strtod([part(linha(indi(bl)-2),[13:14]) part(linha(indi(bl)-2),[16:17]) part(linha(indi(bl)-2),[19:20])]);
            horaf=horaf-[3 0 0];
    
            //le os dados do bloco escolhido
            mprintf('Carregando novos dados...');
            
            for i=indi(bl)+1:indf(bl)
                tempo(i-indi(bl))=strtod(part(linha(i),[1:16]));
                pot1(i-indi(bl))=strtod(part(linha(i),[17:33]))-z(1);
                pot2(i-indi(bl))=strtod(part(linha(i),[34:50]))-z(2);
                pot3(i-indi(bl))=(strtod(part(linha(i),[51:67]))-z(3))*-1;
                pot4(i-indi(bl))=strtod(part(linha(i),[68:84]))-z(4);
                pot5(i-indi(bl))=strtod(part(linha(i),[85:101]))-z(5);
            end
            mprintf('OK\n');
            
            scf(1);
            a=gca();
            b=a.children;
            delete(b);
            a=gca();
            a.data_bounds=[min(tempo),-30;max(tempo),30];
            a.tight_limits='on';
            a.auto_scale='off';
            a.title.text=hora_string(bl);
            plot(tempo,pot1,'r');
            plot(tempo,pot2,'b');
            plot(tempo,pot3,'k');
            plot(tempo,pot4,'y');
            plot(tempo,pot5,'g');
            
            hl=legend(['LEME';'PD';'PE';'AD';'AE'],4,%f);
            
            set(bot0,'value', 1);
            set(bot1,'value', 1);
            set(bot2,'value', 1);
            set(bot3,'value', 1);
            set(bot4,'value', 1);
            
        end
    
    //escreve tempo total de aquisicao do arquivo
    
    endfunction
    
    pause
    
endfunction
