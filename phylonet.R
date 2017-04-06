

# Load required libraries and set working directory and species file
library("rentrez")
workingDirectory="/home/alvaro/Documents/Phylonet"
setwd(workingDirectory)
file<-"species.csv"
# Load species file
species<-read.csv("species.csv")

# Set vector of search keywords
gene_Search= ("18S 18s")

# This function downloads the specified number of sequences per species of a specified gene
download_sequences = function(speciesFile,gene_Search,nSeq=1,
                              format="fasta",path=getwd(),db="nucleotide"){
  
# In each iteration, a multifasta file is downloaded per species
  line=1
  
  for(line in 1:length(species$Sp)){
    search<-entrez_search(db,
                          term=paste(species$Sp[line],"[ORGN]","&", gene_Search),
                          use_history=TRUE)
    all_recs <- entrez_fetch(db="nucleotide", web_history = search$web_history, rettype=format)
    write(all_recs,file=paste(species$Sp[line],".",format,sep = ""))
    print(paste("Number of sequences of the species ",species$Sp[line],":",sep = ""))
    print(search$count)
    }
}

download_sequences(species,gene_Search)
