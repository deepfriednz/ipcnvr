#!/bin/bash

function getCams {
	inputFile=$1
	out=()
	while IFS= read -r var;
	do
	#	echo "line read: $var"
		out+=("$var")	
	done < "$inputFile"
	echo ${out[@]}
}
