#!/bin/bash

function getCams {
	inputFile=$1
	out=()
	while IFS= read -r var
	do
		out+=("$var")	
	done < "$inputFile"
	echo $out
}
