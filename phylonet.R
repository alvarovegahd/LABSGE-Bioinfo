# The user should change the last two lines of this file and then run all the lines of this script
# A csv species file with just one column with a header "Sp" and a species name per row is required

#--------------------------------------------------------------------------------------------------------------------
# Load required libraries and set working directory
library("rentrez")

# This function downloads the specified number of sequences per species of a specified gene
download_sequences = function(speciesFile,gene_Search,nSeq=1,
                              format="fasta",path=getwd(),db="nucleotide",multi=T){
  # To generate logfile
  logFile <<- file("phylonetRun.log")
  sink(logFile, append=TRUE)
  sink(logFile, append=TRUE, type="message")

  # Import csv as object named "species"
  species <- read.csv(speciesFile)
  
  # In each iteration, a multifasta file is downloaded per species
  line=1

  for(line in 1:length(species$Sp)){
    search<-entrez_search(db,
                          term=paste(species$Sp[line],"[ORGN]","&", gene_Search),
                          use_history=TRUE,retmax=nSeq)
    print(paste("Number of sequences of the species ",species$Sp[line],":",sep = ""))
    print(search$count)
    
    if(search$count == 0){ # Avoid creating empty files
      print(paste("WARNING: There are no sequences available given the search terms for the gene ",gene_Search, " of the species ",species$Sp[line],sep=""))
    } 

    else {

    all_recs <- entrez_fetch(db="nucleotide", web_history = search$web_history, rettype=format,retmax=nSeq)

    if(multi){
      write(all_recs,file=paste("PhylonetRun",Sys.Date(),".",format,sep = ""),append=T)
    } 
    else {
    cat(all_recs,file=paste(species$Sp[line],".",format,sep = ""))
    }
    }
  }
  closeAllConnections() # Close console connection to logfile
}
#----------------------------------------------------------------------------------------------------------------------------
# The user just have to change the following two lines
setwd("/home/alvaro/Documents/Phylonet") # Set working directory
download_sequences(speciesFile="species.csv",gene_Search="18s 18S",nSeq=3)
