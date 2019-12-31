function arq=escolhe_arquivo(caminho,ext,texto)

//Carrega arquivos na pasta entrada
S=dir(caminho)
nomes=S.name

nomes_filt=[]

n1=size(nomes,1)
for i=1:n1
  if S.isdir(i)==%f
    nomes_filt=[nomes_filt;nomes(i)]
  end
end


//Filtra arquivos que nao tenham a extensao equil
n=size(nomes_filt,1)
for i=1:n
 nome=nomes_filt(i)
 [path,fname,extension]=fileparts(caminho+nome)   
  //Trabalha apenas se a extensão do arquivo é do tipo equil
  if extension==ext
    nomes2(i)=nome  
  end   
end

//Menu para a escolha do caso
  rep=x_choose(nomes2,texto)

arq=nomes2(rep)

endfunction
