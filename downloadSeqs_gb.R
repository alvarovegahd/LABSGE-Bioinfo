"""
# Descargador de secuencias en formato GenBank, que genera un archivo por especie a partir de una 
lista de especies conteniendo todos los registros disponibles en el NCBI, v. Demo Alvaro Vega, 2017
Para ejecutar este programa, modifique las variables directorioDeTrabajo y archivo, tomando en 
consideracion las anotaciones a estas variables #

--------------------------------------------------------------------------------------------------

Tutorial de paquete rentrez:
https://cran.r-project.org/web/packages/rentrez/vignettes/rentrez_tutorial.html

"""
#Esta es la direccion del folder que contiene el archivo .csv y en el cual se depositaran los archivos resultantes
directorioDeTrabajo="/home/alvaro/Documents/LABSGE Federico Alvaro/descargarSecs/Prueba1" 
#Archivo separado por comas que contiene la lista de especies a descargar archivos del genBank y encabezado Sp
archivo="especies.csv" 
#----------------------------------------------------------------------------
library("rentrez")
setwd(directorioDeTrabajo)
especies<-read.csv(archivo)

#Descargar
renglon=1
for(renglon in 1:length(especies$Sp)){
search<-entrez_search(db="nucleotide",
              term=paste(especies$Sp[renglon],"[ORGN]"),
              use_history=TRUE)
all_recs <- entrez_fetch(db="nucleotide", web_history = search$web_history, rettype="gb")
write(all_recs,file=paste(especies$Sp[renglon],".gb",sep = ""))
print(paste("Numero de secuencias de la especie ",especies$Sp[renglon],":",sep = ""))
print(search$count)
}
