function velocimetro()

xdel(winsid());

n=1000;

cor0=color('white');
    
//dados de velocidade dummy
for i=1:n
    V(i)=65+sin(1*i*%pi/180)*10;
end
    
//Le a imagem do velocimetro
//imagem='C:\Users\Alexandre\Desktop\velocimetro.png';
//imagem='C:\Users\ASUS\Documents\MATLAB\Doutorado\Cenic\Ensaios\18_04_05\18_04_05\01_programa_scilab_utilizado';
imagem='/home/rcavalcanti/Mestrado/ProjetoTelemasterCenic/dados_telemetria/18_04_05/Telemetria_Adiconado_Crossbow/01_programa_scilab_c_Crossbow';
S=imread(imagem);
imshow(S);
a=gca();
a.isoview='on';
a.margins=[0,0,0,0];
a.data_bounds=[0.5 0.5; 455.5 455.5];

fig=scf(0);
//fig.figure_size=[477,587];
fig.figure_size=[300,400];
fig.toolbar_visible = "off";
fig.menubar_visible = "off";
fig.infobar_visible = "off";

i=1;
//plota ponteiro
while i<n
   //calcula angulo do ponteiro
   xpont(1)=int(455/2);
   ypont(1)=int(455/2);
   xpont(2)=xpont(1)+sin((V(i)-23)*1.95*%pi/180)*150;
   ypont(2)=ypont(1)+cos((V(i)-23)*1.95*%pi/180)*150;
   //plota ponteiro
   plot2d(xpont,ypont,style=cor0);
   p=get('hdl');
   p.children.thickness=4;
   p.children.arrow_size_factor=0.5;
   p.children.polyline_style=4;
   drawnow();
   drawlater();
   a=gca();
   b=a.children;
   delete(b(1));
   i=i+1;
end

    
endfunction
