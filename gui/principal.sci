function principal()
    
    //vai para o diretorio onde serao gravados os arquivos
    //cd C:\Users\gpogor\Desktop\temp_VANT_A\rotinas_Telemaster\gui
    //cd C:\Users\ASUS\Documents\MATLAB\Doutorado\Cenic\Ensaios\Telemetria_Adiconado_Crossbow\01_programa_scilab_c_Crossbow\gui\
    cd /home/rcavalcanti/Mestrado/ProjetoTelemasterCenic/dados_telemetria/18_04_05/Telemetria_Adiconado_Crossbow/01_programa_scilab_c_Crossbow/gui

    //apaga as janelas graficas correntes
    xdel(winsid());
    clear
    clc
    
    exec('plota_arduino_scilab_v2.sci',-1);
    
    plota_arduino_scilab_v2()
    
endfunction
