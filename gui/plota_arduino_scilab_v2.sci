function plota_arduino_scilab_v2()
 
//a funçao utiliza o Serial Communication Toolbox para o Scilab, que deve ser instalado
//previamente. para instalar digite no console: "atomsInstall('serial')"


//variaveis globais
global escreve
global stop
global start
    
escreve=%t;

//cria e formata a figura dos potenciometros
janela=figure(1);
janela.background=8;
janela.toolbar_visible='off';
janela.menubar_visible='off';
janela.infobar_visible='off';
janela.background=8;
janela.figure_position = [-8,-8];
//janela.figure_size = [1382,784];
janela.figure_size=[576,784];
a=gca();
a.data_bounds=[0,0;10,60];
a.tight_limits='on';
a.auto_scale='off';
a.box='on';
a.grid=[1 1];
a.thickness=2;
a.grid_thickness=1;
a.font_size=3;
a.title.font_size=5;
a.x_label.text='tempo(s)';
a.x_label.font_size=4;
a.y_label.text='leitura';
a.y_label.font_size=4;

//cria e formata a figura do mapa gps
janela2=figure(2);
janela2.background=8;
janela2.toolbar_visible='off';
janela2.menubar_visible='off';
janela2.infobar_visible='off';
janela2.background=8;
janela2.figure_position = [576,-8];
janela2.figure_size=[747,784];
a=gca();
a.tight_limits='on';
a.box='on';
a.font_size=3;
a.title.font_size=5;
a.x_label.text='S';
a.x_label.font_size=4;
a.y_label.text='E';
a.y_label.font_size=4;
a.isoview='on';

//cria e formata a figura do horizonte artificial
horiz=figure(3);
horiz.figure_position=[500,100];
horiz.figure_size=[400,500];
horiz.background=8;
horiz.toolbar_visible='off';
horiz.menubar_visible='off';
horiz.infobar_visible='off';
horiz.background=8;
a=gca();
a.data_bounds=[-1,-1;1,1];
a.box='off';
a.clip_state='off';
a.axes_visible=['off','off','off'];
a.auto_ticks=['off','off','off'];
a.auto_margins='off';
a.tight_limits='on';
a.auto_scale='off';
a.isoview='on';
a.grid_style=[3,3];
a.grid=[-1,-1,-1];
a.x_label.text='';
a.y_label.text='';
a.z_label.text='';
    
scf(2);
    
n = x_choose(['Galpao CENIC';'Pista Caçapava';'Fazenda Maristela';'Univap';'Ipua cab 08';'Aeroclube Pinda';'baixar outro mapa da internet'],['Escolha base'],'Cancela');

if n==0 then
    mprintf('Rodada abortada pelo usuario\n');
    abort
elseif n==1 then
    //galpao CENIC
    lat0=-23.247324;
    long0=-45.929397;
    zoom=18;
    //imagem='C:\Users\gpogor\Desktop\temp_VANT_A\rotinas_Telemaster\mapa_cenic.png';
    //imagem='C:\Users\ASUS\Documents\MATLAB\Doutorado\Cenic\Ensaios\18_04_05\18_04_05\01_programa_scilab_utilizado\mapa_cenic.png';
    imagem='/home/rcavalcanti/Mestrado/ProjetoTelemasterCenic/dados_telemetria/18_04_05/Telemetria_Adiconado_Crossbow/01_programa_scilab_c_Crossbow/mapa_cenic.png';
    S=imread(imagem);
elseif n==2 then
    //pista em Caçapava
    lat0=-23.088514;
    long0=-45.702324;
    zoom=17;
    //imagem='C:\Users\gpogor\Desktop\temp_VANT_A\rotinas_Telemaster\mapa_cacapava.png';
    //imagem='C:\Users\ASUS\Documents\MATLAB\Doutorado\Cenic\Ensaios\18_04_05\18_04_05\01_programa_scilab_utilizado\mapa_cacapava.png';
    imagem='/home/rcavalcanti/Mestrado/ProjetoTelemasterCenic/dados_telemetria/18_04_05/Telemetria_Adiconado_Crossbow/01_programa_scilab_c_Crossbow/mapa_cacapava.png'
    S=imread(imagem);
    //url Caçapava
    //https://maps.googleapis.com/maps/api/staticmap?center=-23.088514,-45.702324&zoom=17&size=600x600&scale=2&maptype=satellite&key=AIzaSyB0esiJks_sHiwFe6KexrTOnJ96Tq5fii4
elseif n==3 then
    //pista Maristela
    lat0=-22.953956;
    long0=-45.603723;
    zoom=17;
    //imagem='C:\Users\gpogor\Desktop\temp_VANT_A\rotinas_Telemaster\mapa_maristela.png';
    imagem='C:\Users\ASUS\Documents\MATLAB\Doutorado\Cenic\Ensaios\18_04_05\18_04_05\01_programa_scilab_utilizado\mapa_maristela.png';
    S=imread(imagem);
elseif n==4 then
    lat0=-23.217429;
    long0=-45.969402;
    zoom=17;
    //imagem='C:\Users\gpogor\Desktop\temp_VANT_A\rotinas_Telemaster\mapa_univap.png';
    //imagem='C:\Users\ASUS\Documents\MATLAB\Doutorado\Cenic\Ensaios\18_04_05\18_04_05\01_programa_scilab_utilizado\mapa_univap.png';
    imagem='/home/rcavalcanti/Mestrado/ProjetoTelemasterCenic/dados_telemetria/18_04_05/Telemetria_Adiconado_Crossbow/01_programa_scilab_c_Crossbow/mapa_univap.png';
    S=imread(imagem);
elseif n==5 then
    lat0=-23.045338;
    long0=-45.779554;
    zoom=17;
    //imagem='C:\Users\gpogor\Desktop\temp_VANT_A\rotinas_Telemaster\mapa_ipua_08.png';
    //imagem='C:\Users\ASUS\Documents\MATLAB\Doutorado\Cenic\Ensaios\18_04_05\18_04_05\01_programa_scilab_utilizado\mapa_ipua_08.png';
    imagem='/home/rcavalcanti/Mestrado/ProjetoTelemasterCenic/dados_telemetria/18_04_05/Telemetria_Adiconado_Crossbow/01_programa_scilab_c_Crossbow/mapa_ipua_08.png';
    S=imread(imagem);
elseif n==6 then
    lat0=-22.944177;
    long0=-45.431527;
    zoom=16;
    //imagem='C:\Users\gpogor\Desktop\temp_VANT_A\rotinas_Telemaster\mapa_pinda.png';
    //imagem='C:\Users\ASUS\Documents\MATLAB\Doutorado\Cenic\Ensaios\18_04_05\18_04_05\01_programa_scilab_utilizado\mapa_pinda.png';
    imagem='/home/rcavalcanti/Mestrado/ProjetoTelemasterCenic/dados_telemetria/18_04_05/Telemetria_Adiconado_Crossbow/01_programa_scilab_c_Crossbow/mapa_pinda.png';
    S=imread(imagem);
elseif n==7 then
    ok=0;
    while ok==0
        rep = x_mdialog(['Entre as coordenadas do centro do mapa';'e o zoom desejado'],['lat0';'long0';'zoom'],['-23.247324';'-45.929397';'16']);
        if rep==[] then
            mprintf('Cancelado pelo usuario');
            abort
        end
        val=strtod(rep);
        if isnan(sum(val))==%f then
            ok=1;
            lat0=val(1);
            long0=val(2);
            zoom=val(3);
            center_loc=[lat0,long0];
            api='AIzaSyB0esiJks_sHiwFe6KexrTOnJ96Tq5fii4';
            url="https://maps.googleapis.com/maps/api/staticmap?center="+strcat(string(center_loc),',')+"&zoom="+string(zoom)+"&size=600x600&scale=2&maptype=satellite&key="+api;
            fn=getURL(url);
            S=imread(fn);
        end
    end
end

//res=[600,600];
sz=size(S);
imshow(S);
a=gca();
a.isoview='on';
a.data_bounds=[0.5 0.5; 1200.5 1200.5];

[x_ret,y_ret]=get_pixel(long0,lat0,long0,lat0,zoom);
plot(2*x_ret+sz(2)/2,-2*y_ret+sz(1)/2,'b*');
f =gcf();
f.children.margins=[0 0 0 0];

//constroi a GUI com botoes para ativar ou desativar gravacao
//cria botoes de interface com usuario
//btao inicia aquisicao
bot0=uicontrol(janela,'style','pushbutton');
set(bot0,'position',[10 10 150 20]);
set(bot0,'callback','aquisicao');
set(bot0,'string','inicia aquisicao');

//botao interrompe aquisicao
bot1=uicontrol(janela,'style','pushbutton');
set(bot1,'position',[10 30 150 20]);
set(bot1,'callback','interrompe');
set(bot1,'callback_type',10);
set(bot1,'string','interrompe aquisicao');

//botao escreve dados no prompt
bot2=uicontrol(janela,'style','pushbutton');
set(bot2,'position',[10 50 150 20]);
set(bot2,'callback','escreve_prompt');
set(bot2,'callback_type',10);
set(bot2,'string','escreve prompt');

//campo frequencia de aquisicao
bot3=uicontrol(janela,'style','text');
set(bot3,'position',[250 640 80 50]);
set(bot3,'string','00.0');
set(bot3,'VerticalAlignment','Top');
set(bot3,'HorizontalAlignment','Center');
set(bot3,'fontsize',24);

//label frequencia de aquisicao arduino
bot4=uicontrol(janela,'style','text');
set(bot4,'position',[220 690 150 30]);
set(bot4,'string','Freq de Aquisição (Hz)');
set(bot4,'VerticalAlignment','Top');
set(bot4,'HorizontalAlignment','Center');
set(bot4,'fontsize',14);

//campo distancia em m
bot5=uicontrol(janela2,'style','text');
set(bot5,'position',[100 640 80 50]);
set(bot5,'string','000');
set(bot5,'VerticalAlignment','Top');
set(bot5,'HorizontalAlignment','Center');
set(bot5,'fontsize',24);

//label distancia em m
bot6=uicontrol(janela2,'style','text');
set(bot6,'position',[70 690 160 30]);
set(bot6,'string','distancia da base (m)');
set(bot6,'VerticalAlignment','Top');
set(bot6,'HorizontalAlignment','Center');
set(bot6,'fontsize',14);

////campo frequencia de aquisicao gps
//bot7=uicontrol(janela2,'style','text');
//set(bot7,'position',[350 640 80 50]);
//set(bot7,'string','00.0');
//set(bot7,'VerticalAlignment','Top');
//set(bot7,'HorizontalAlignment','Center');
//set(bot7,'fontsize',24);
//
////label frequencia de aquisicao gps
//bot8=uicontrol(janela2,'style','text');
//set(bot8,'position',[320 690 160 30]);
//set(bot8,'string','Freq de Aquisição GPS(Hz)');
//set(bot8,'VerticalAlignment','Top');
//set(bot8,'HorizontalAlignment','Center');
//set(bot8,'fontsize',14);

//campo velocidade aerodinamica
bot9=uicontrol(janela2,'style','text');
set(bot9,'position',[550 640 80 50]);
set(bot9,'string','00.0');
set(bot9,'VerticalAlignment','Top');
set(bot9,'HorizontalAlignment','Center');
set(bot9,'fontsize',24);

//label velocidade aerodinamica
bot10=uicontrol(janela2,'style','text');
set(bot10,'position',[520 690 160 30]);
set(bot10,'string','Vaed (m/s)');
set(bot10,'VerticalAlignment','Top');
set(bot10,'HorizontalAlignment','Center');
set(bot10,'fontsize',14);





//rola mapa para a direita
bot100=uicontrol(janela2,'style','pushbutton');
set(bot100,'position',[690 350 50 50]);
set(bot100,'string','>');
set(bot100,'VerticalAlignment','Top');
set(bot100,'HorizontalAlignment','Center');
set(bot100,'fontsize',24);
set(bot100,'callback','rola_tela(1)');
//rola mapa para a esquerda
bot200=uicontrol(janela2,'style','pushbutton');
set(bot200,'position',[0 350 50 50]);
set(bot200,'string','<');
set(bot200,'VerticalAlignment','Top');
set(bot200,'HorizontalAlignment','Center');
set(bot200,'fontsize',24);
set(bot200,'callback','rola_tela(2)');
//rola mapa para cima
bot300=uicontrol(janela2,'style','pushbutton');
set(bot300,'position',[350 680 50 50]);
set(bot300,'string','U');
set(bot300,'VerticalAlignment','Top');
set(bot300,'HorizontalAlignment','Center');
set(bot300,'fontsize',24);
set(bot300,'callback','rola_tela(3)');
//rola mapa para baixo
bot400=uicontrol(janela2,'style','pushbutton');
set(bot400,'position',[350 0 50 50]);
set(bot400,'string','D');
set(bot400,'VerticalAlignment','Top');
set(bot400,'HorizontalAlignment','Center');
set(bot400,'fontsize',24);
set(bot400,'callback','rola_tela(4)');

bot500=uicontrol(janela2,'style','pushbutton');
set(bot500,'position',[0 0 140 25]);
set(bot500,'string','Limpar trajetoria');
set(bot500,'VerticalAlignment','Top');
set(bot500,'HorizontalAlignment','Center');
set(bot500,'fontsize',14);
set(bot500,'callback','limpa_traj');

pause

endfunction

function rola_tela(tipo)
    if tipo==1 then
        vec=[60 0 60 0 0 0]
    elseif tipo==2 then
        vec=[-60 0 -60 0 0 0]
    elseif tipo==3 then
        vec=[0 60 0 60 0 0]
    else
        vec=[0 -60 0 -60 0 0]
    end
    scf(2);
    a=gca();
    zoom2=a.zoom_box;
    if zoom2~=[] then
        a.zoom_box=a.zoom_box+vec;
    end
endfunction

function limpa_traj()
    scf(2);
    a=gca();
    b=a.children;
    tam=size(b,1);
    if tam>2 then
        delete(b(1:tam-2));
    end
endfunction

function aquisicao()

//cores do horiz artif
cor(1)=color('white');
cor(2)=color('scilabbrown3');
cor(3)=color('scilabblue2');
cor(4)=color('yellow');

//pontos de linhas auxiliares
angs=[-60 -30 30 60];
comp=[0.3 0.15 0.15 0.3]
nangs=size(angs,2);
for j=1:nangs
    pt2(j,1)=comp(j)
    pt2(j,2)=angs(j)/90;
    pt1(j,1)=-comp(j);
    pt1(j,2)=angs(j)/90;
end

//pontos do horizonte
p1=[1000 0];
p2=[-1000 0];
//pontos da terra
pe1=[1000 -10];
pe2=[-1000 -10];
//pontos do ceu
ps1=[1000 10];
ps2=[-1000 10];
    
//variaveis globais
global escreve
global stop
global start

stop=%f;

if (getos() == "Windows") then
    if ~(atomsIsInstalled('serial')) then
        msg=_("ERRO: Uma toolbox de comunicacao serial precisa ser instalada.");
        messagebox(msg, "Erro", "erro");
        error(msg);
        return;
    end
    if ~(atomsIsInstalled('IPCV')) then
        msg=_("ERRO: Uma toolbox de processamento de imagens precisa ser instalada.");
        messagebox(msg, "Erro", "erro");
        error(msg);
        return;
    end
        
    port_name=evstr(x_dialog('Numero da porta COM: ','2'))
    if port_name==[] then
        msg=_("ERRO: Nenhuma porta serial foi escolhida. ");
        messagebox(msg, "ERRO", "erro");
        error(msg);
        return;
    end
elseif (getos() == "Linux") then
    if ~(atomsIsInstalled('serial')) then
        msg=_("ERRO: Uma toolbox de comunicacao serial precisa ser instalada.");
        messagebox(msg, "Erro", "erro");
        error(msg);
        return;
    end
    if ~(atomsIsInstalled('IPCV')) then
        msg=_("ERRO: Uma toolbox de processamento de imagens precisa ser instalada.");
        messagebox(msg, "Erro", "erro");
        error(msg);
        return;
    end
        
    port_name=x_dialog('Endereço da porta serial: ','//dev//ttyUSB0');
    if port_name==[] then
        msg=_("ERRO: Nenhuma porta serial foi escolhida. ");
        messagebox(msg, "ERRO", "erro");
        error(msg);
        return;
    end
else
    msg=_("ERRO: Este programa funciona somente em SO Windows. ");
    messagebox(msg, "ERRO", "erro");
    error(msg);
    return;
end

//abre porta serial
h=openserial(port_name,smode='57600,n,8,1');//,blocking=%t,timeout=1000);
sleep(1000);

i=2;//inicia contador
escala=1;//inicia escala do grafico
n=90000;//numero maximo de pontos a serem plotados
num=10;//intevalo de tempo máximo em segundos a ser plotado em cada tela
frequ=60;//frequncia de plotagem (Hz)
int_plot=1;

//inicia variaveis
tempo(1)=0;
pot1(1)=0;
pot2(1)=0;
pot3(1)=0;
pot4(1)=0;
pot5(1)=0;
V(1)=0;
alfa(1)=0;
Beta(1)=0;
phi(1)=0;
theta(1)=0;
lat(1)=lat0;
long(1)=long0;
alt(1)=600;
dist(1)=0;
rollat(1)=0;
pitchat(1)=0;
headingat(1)=0;
rollrt(1)=0;
pitchrt(1)=0;
headingrt(1)=0;
acelx(1)=0;
acely(1)=0;
acelz(1)=0;
fhz(1)=0;
vec(1)=[];
npgps=1;

if escreve==%t then
    mprintf('Tempo(s) pot1(º) pot2(º) pot3(º) pot4(º) pot5(º) V(m/s) alfa(º) beta(º) ang(º) rollat(º) pitchat(º) headingat(º) rollrt(º) pitchrt(º) headingrt(º) acelx(g) acely(g) acelz(g)\n');
end

vec_temp=[];
realtimeinit(1/frequ);//define frequencia de plotagem
realtime(0);//define tempo inicial como zero
while i<=n, realtime(i)
    tic
    achou=0;
    //le ultimos 89 caracteres do buffer serial
    vec(i)=readserial(h,178);
    //vec(i)=readserial(h,300);
    if vec(i)~='' then  //achou algum valor
        vec_temp=vec(i-1);
        flag(i)=0;
        //separa as linhas das entradas
        vec2=strsplit(vec(i),ascii(10));
        //tamanho do vetor de strings
        tam=size(vec2,1);
        //encontra a ultima linha com numero de caracteres de cada entrada
        j=tam;
        while (j>0 & achou==0)
            if (length(vec2(j,1))==151) then
                ind=j;
                temp=strsplit(vec2(ind,1),' ');
                var1=strtod(temp(1:24));
                if length(temp(1))==8 then  //verifica se a linha de 89 caracteres tem 15 campos
                    if isnan(sum(var1))==%f then  //verifica se sao todos dados numericos
                        achou=1;
                    end
                end
            end
            j=j-1
        end
        //tenta de novo, acrescentando parte da ultima linha
        if achou==0 then
            vec(i)=vec_temp+vec(i);
            //separa as linhas das entradas
            vec2=strsplit(vec(i),ascii(10));
            //tamanho do vetor de strings
            tam=size(vec2,1);
            j=tam;
            while (j>0 & achou==0)
                if (length(vec2(j,1))==151) then
                    ind=j;
                    temp=strsplit(vec2(ind,1),' ');
                    var1=strtod(temp(1:24));
                    if length(temp(1))==8 then  //verifica se a linha de 89 caracteres tem 15 campos
                        if isnan(sum(var1))==%f then  //verifica se sao todos dados numericos
                            achou=1;
                        end
                    end
                end
                j=j-1;
            end
        end
        
        if achou==1 then  //potenciometros
            tempo(i)=var1(1)/1000;
            pot1(i)=var1(2)/100;
            pot2(i)=var1(3)/100;
            pot3(i)=var1(4)/100;
            pot4(i)=var1(5)/100;
            pot5(i)=var1(6)/100;
            V(i)=var1(7)/100;
            alfa(i)=var1(8);
            Beta(i)=var1(9);
            phi(i)=(((var1(14)/100)-500))*-1;
            theta(i)=((var1(15)/100)-500)*-1;
            lat(i)=(var1(10)/1e7)*-1;
            long(i)=(var1(11)/1e7)*-1;
            alt(i)=var1(12)/1e3;
            dist(i)=var1(13)/1e3;
            rollat(i)=var1(16);
            pitchat(i)=var1(17);
            headingat(i)=var1(18);
            rollrt(i)=var1(19);
            pitchrt(i)=var1(20);
            headingrt(i)=var1(21);
            acelx(i)=var1(22);
            acely(i)=var1(23);
            acelz(i)=var1(24);

            // Converte as variáveis para as unidades originais. As variáveis foram multiplicadas por 100 para retirar a virgula, portanto aqui é dividida. Variáveis com valores negativo foram somados 20000(ângulos), 30000(rates) ou 2000(aceleração)
            if rollat(i)>=20000 then
                rollat(i)=((rollat(i)-20000)/100)*-1;
            else
                rollat(i)=(rollat(i)/100);
            end
            if pitchat(i)>=20000 then
                pitchat(i)=((pitchat(i)-20000)/100)*-1;
            else
                pitchat(i)=(pitchat(i)/100);
            end
            if headingat(i)>=20000 then
                headingat(i)=((headingat(i)-20000)/100)*-1;
            else
                headingat(i)=(headingat(i)/100);
            end
           if rollrt(i)>=30000 then
                rollrt(i)=((rollrt(i)-30000)/100)*-1;
            else
                rollrt(i)=(rollrt(i)/100);
            end
            if pitchrt(i)>=30000 then
                pitchrt(i)=((pitchrt(i)-30000)/100)*-1;
            else
                pitchrt(i)=(pitchrt(i)/100);
            end
            if headingrt(i)>=30000 then
                headingrt(i)=((headingrt(i)-30000)/100)*-1;
            else
                headingrt(i)=(headingrt(i)/100);
            end
              if acelx(i)>=2000 then
                acelx(i)=((acelx(i)-2000)/100)*-1;
            else
                acelx(i)=(acelx(i)/100);
            end
            if acely(i)>=2000 then
                acely(i)=((acely(i)-2000)/100)*-1;
            else
                acely(i)=(acely(i)/100);
            end
            if acelz(i)>=2000 then
                acelz(i)=((acely(i)-2000)/100)*-1;
            else
                acelz(i)=(acelz(i)/100);
            end

        else
            
            continue
            
            
        end
        
        //plotagem
        if i==2 then
            scf(1);
            //acerta a escala de tempo
            escala=floor(tempo(i)/num);
            a=gca();
            a.data_bounds=[num*escala,20;num*(escala+1),70];
        end
        
        if i>int_plot+1 & modulo(i,int_plot)==0 then
            //plota potenciometros
            scf(1);
            plot2d([tempo(i-int_plot) tempo(i)],[pot1(i-int_plot) pot2(i-int_plot) pot3(i-int_plot) pot4(i-int_plot) pot5(i-int_plot); pot1(i) pot2(i) pot3(i) pot4(i) pot5(i)],[2 5 9 13 16]);
            if tempo(i)>num*escala then
                a=gca();



                a.data_bounds=[num*escala,0;num*(escala+1),65];
                delete(a.children);
                escala=escala+1;
            end
            
            //plota gps
            scf(2);
            if lat(i-int_plot)~=lat(i) then
                //npgps=npgps+1;
                [x_ret,y_ret]=get_pixel(long(i),lat(i),long0,lat0,zoom);
                plot(2*x_ret+sz(2)/2,-2*y_ret+sz(1)/2,'r.');
                str_dist=msprintf('%6.1f',dist(i)*1000);
                //atualiza o campo de distancia na tela
                set(bot5,'string',str_dist);
            end
            
            //plota Crossbow
            scf(4);
            plot2d([tempo(i-int_plot) tempo(i)],[rollat(i-int_plot) pitchat(i-int_plot) headingat(i-int_plot); rollat(i) pitchat(i) headingat(i)]);
            if tempo(i)>num*escala then
                a=gca();
                a.data_bounds=[num*escala,0;num*(escala+1),65];
                delete(a.children);
                escala=escala+1;
            end 
            
            scf(5);
            plot2d([tempo(i-int_plot) tempo(i)],[rollrt(i-int_plot) pitchrt(i-int_plot) headingrt(i-int_plot); rollrt(i) pitchrt(i) headingrt(i)]);
            if tempo(i)>num*escala then
                a=gca();
                a.data_bounds=[num*escala,0;num*(escala+1),65];
                delete(a.children);
                escala=escala+1;
            end 
            
            scf(6);
            plot2d([tempo(i-int_plot) tempo(i)],[acelx(i-int_plot) acely(i-int_plot) acelz(i-int_plot); acelx(i) acely(i) acelz(i)]);
            if tempo(i)>num*escala then
                a=gca();
                a.data_bounds=[num*escala,0;num*(escala+1),65];
                delete(a.children);
                escala=escala+1;
            end 
            
            //atualiza velocidade
            set(bot9,'string',msprintf('%4.1f',V(i)));
            scf(3);
            if theta(i-int_plot)~=theta(i) then
                //plota dados no horizonte artificial
                horizonte(phi(i),theta(i),cor,angs,comp,nangs,pt1,pt2,p1,p2,pe1,pe2,ps1,ps2);
            end
        end
        
        tempo2=toc();
        
        //calcula frequencia de aquisicao
        fhz(i)=1/tempo2;
        
        if i>10 then
            fhz2(i)=1/((tempo(i)-tempo(i-10))/10);
            //atualiza o campo de freqeuncia de aquisicao na tela
            set(bot3,'string',msprintf('%4.1f',fhz2(i)));
        end
        
        if escreve==%t then
            mprintf('%4i t=%.2fs p1=%.2f p2=%.2f p3=%.2f p4=%.2f p5=%.2f lat=%.6f long=%.6f alt=%.0f dist=%.3f roll=%.2f pitch=%2f heading=%.2f rollrt=%.2f pitchrt=%.2f headingrt=%.2f acelx=%.2f acely=%.2f acelz=%.2f V=%.3f\n',i,tempo(i),pot1(i),pot2(i),pot3(i),pot4(i),pot5(i),lat(i),long(i),alt(i),dist(i),rollat(i),pitchat(i),headingat(i),rollrt(i),pitchrt(i),headingrt(i),acelx(i),acely(i),acelz(i),V(i));
        end
        
        i=i+1;
        
    end
    
    //verifica a variavel stop para saber se continua a execução
    if stop==%t then
        closeserial(h);
        n=x_choose(['Sim';'Nao'],['Deseja salvar os dados coletados?'],'Return');
        opt=evstr(n);
        if opt==1 then
            flag_salva=1;
            mprintf('Salvando os dados coletados\n');
        else
            flag_salva=0;
            mprintf('Dados nao salvos\n');
        end
        salva(h,tempo,pot1,pot2,pot3,pot4,pot5,V,alfa,Beta,phi,theta,lat,long,alt,dist,rollat,pitchat,headingat,rollrt,pitchrt,headingrt,acelx,acely,acelz,i-1,flag_salva);
        clear tempo,pot1,pot2,pot3,pot4,pot5,V,alfa,Beta,phi,theta,lat,long,alt,dist,rollat,pitchat,headingat,rolrt,pitchrt,headingrt,acelx,acely,acelz,i
        break
    end
end

endfunction

//funcao para alternar escrita no prompt ligada ou desligada
function escreve_prompt()
    
    global escreve
    
    if escreve==%t then
        escreve=%f
    else
        escreve=%t
    end
    
endfunction

//funcao que interrompe a aquisicao de dados
function interrompe()
    
    global stop
    
    stop=%t
    
endfunction

//funcao que salva os dados no disco e apresenta estatisticas de gravacao
function salva(h,tempo,pot1,pot2,pot3,pot4,pot5,V,alfa,Beta,phi,theta,lat,long,alt,dist,rollat,pitchat,headingat,rollrt,pitchrt,headingrt,acelx,acely,acelz,i,flag_salva)
    
    if flag_salva==1 then
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
            mfprintf(fd,'%16.3f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f %16.7f %16.7f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f %16.2f\n',tempo(j),pot1(j),pot2(j),pot3(j),pot4(j),pot5(j),V(j),alfa(j),Beta(j),phi(j),theta(j),lat(j),long(j),alt(j),dist(j),rollat(j),pitchat(j),headingat(j),rollrt(j),pitchrt(j),headingrt(j),acelx(j),acely(j),acelz(j));
        end
        
        mclose(fd);
    end

    //imprime estatisticas
    indt=max(find(tempo==0));
    dt=tempo(i-1)-tempo(indt+1);
    mprintf('Tempo total de aquisicao (s): %10.3f\n',dt);
    mprintf('Numero total de pontos coletados: %d\n',i);
    mprintf('Frequencia media de aquisiçao (Hz): %d\n',i/dt);
    
endfunction

//funcao que calcula onde plotar os pontos do gps
function [x_ret,y_ret]=get_pixel(lat,lng,lat_center,lng_center,zoom_level)
 
    offset=268435456; // half of the earth circumference's in pixels at zoom level 21
    rad=offset/%pi;
 
    function l2x=lat2x(lat)
        l2x=int(round(offset+rad*lat*%pi/180));
    endfunction
 
    function l2y=lng2y(lng)
        l2y=int(round(offset-rad*log((1+sin(lng*%pi/180))/(1-sin(lng*%pi/180)))/2));
    endfunction
 
 
    x_ret=(lat2x(lat)-lat2x(lat_center))/(2^(21-zoom_level));
    y_ret=(lng2y(lng)-lng2y(lng_center))/(2^(21-zoom_level));
 
endfunction


function horizonte(phi,theta,cor,angs,comp,nangs,pt1,pt2,p1,p2,pe1,pe2,ps1,ps2)
    //plota dados do horizonte artificial a cada iteracao
        
    //matriz de rotacao
    matrot=[cos(phi*%pi/180) -sin(phi*%pi/180);sin(phi*%pi/180) cos(phi*%pi/180)];
    //define a reta a ser plotada, com centro em [0 0]
    p1p=matrot*(p1+[0 theta/90])';
    p2p=matrot*(p2+[0 theta/90])';
    pe1p=matrot*(pe1+[0 theta/90])';
    pe2p=matrot*(pe2+[0 theta/90])';
    ps1p=matrot*(ps1+[0 theta/90])';
    ps2p=matrot*(ps2+[0 theta/90])';
    
    //plota terra e ceu
    x=[pe2p(1) pe1p(1) p1p(1) p2p(1) pe2p(1); ps2p(1) p2p(1) p1p(1) ps1p(1) ps2p(1)];
    y=[pe2p(2) pe1p(2) p1p(2) p2p(2) pe2p(2); ps2p(2) p2p(2) p1p(2) ps1p(2) ps2p(2)];
    z=[0 0 0 0 0; 0 0 0 0 0];
    plot3d(x',y',list(z',[cor(2) cor(3)]));
    //plota linha de atitude
    plot2d([p1p(1) p2p(1)],[p1p(2) p2p(2)],style=cor(1));
    //plota linha de horizonte
    plot2d([p1(1) p2(1)],[p1(2) p2(2)],style=cor(4));
    //rotaciona e plota linhas auxiliares
    for j=1:nangs
        pt1p=matrot*(pt1(j,:)+[0 theta/90])';
        pt2p=matrot*(pt2(j,:)+[0 theta/90])';
        plot2d([pt1p(1) pt2p(1)],[pt1p(2) pt2p(2)],style=cor(1));
    end
    //plota circulo de rolagem
    //plot2d(xc,yc,style=cor0);
    a=gca();
    a.rotation_angles=[0 270];
    a.isoview='on';
    i=i+1;
    drawnow();
    drawlater();
    delete(a.children);
    
endfunction
