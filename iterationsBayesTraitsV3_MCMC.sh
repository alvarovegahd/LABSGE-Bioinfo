#!/bin/sh
# Iterator of BayesTraitsV3
# Alvaro Vega Hidalgo
# 2017
# LABSGE

# This variables should be specified by the user,
# and are the files needed by BayesTraitsV3
traits_File="MammalBrainBody.txt"
trees_File="Mammal.trees"
commands_File="MammalCommands.txt"
number_of_iterations=2



################### Code
########### Should not be changed by the user

# Create directories to save results and logs to tracer files
mkdir raw_Results
mkdir logs_to_Tracer

# Iterations of Bayes Traits
for i in $(seq 1 $number_of_iterations); do
	./BayesTraitsV3 $trees_File $traits_File < $commands_File 
	mv $traits_File".Log.txt"  ./raw_Results/$traits_File$i".Log.txt"
        mv $traits_File".Schedule.txt"  ./raw_Results/$traits_File$i".Schedule.txt"
        mv $traits_File".Stones.txt"  ./raw_Results/$traits_File$i".Stones.txt"

	#Quit head
	initial_line=`grep -wn Iteration ./raw_Results/$traits_File$i".Log.txt" |cut -f1 -d:`
        final_line=`wc -l ./raw_Results/$traits_File$i".Log.txt" |cut -f1 -d' '`
	output_length=$(($final_line-$initial_line))
        #Save Tracer files
        tail -n $output_length ./raw_Results/$traits_File$i".Log.txt" > ./logs_to_Tracer/$traits_File$i"toTracer.Log.txt"

done

