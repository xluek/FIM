#!/bin/bash

############################################
##                                        ##
## File Integrity Monitoring check script ##
## Developed by Oscar Arias	(XlueK)       ##
##                                        ##
############################################

workingDir=/tmp/fim
prename="check_"
baseline=$workingDir"/baseline.md5"
IP_address="$(ifconfig | grep 'inet ' | awk {'print $2'})"
checkResult=""
files_to_monitor=(
/path/to/file/sentiveFile1
/path/to/otherFile/sentiveFile2
)

## Check if Working Directory exist, else create directory
if [ ! -d "$workingDir" ]; then
	mkdir $workingDir
fi

## Create a Baseline
if [ -f "$baseline" ]; then
	echo "El baseline SI existe"
else	
	echo "El baseline NO existe. Creando..."
	for file in ${files_to_monitor[@]}; do
		md5sum $file >> $baseline
	done
fi

## Make a check
for file in ${files_to_monitor[@]}; do
	md5sum $file >> $workingDir"/"$prename$(date +%Y-%m-%d_%H%M%S)".md5"
done
checkResult=$(diff $baseline $workingDir"/"$prename$(date +%Y-%m-%d_%H%M%S)".md5")
msg="El servidor monitoreado tiene las direcciones IP: \n"$IP_address"\n\nLos archivos modificados son los siguientes: \n"$checkResult
if [ ! -z "$checkResult" ]; then
	echo "Se modificaron los archivos"
	echo "$checkResult"
	echo -e "$msg" | mail -s "Archivos Modificados en $(hostname)" notification@domain.com
	echo -e "$msg" | mail -s "Archivos Modificados en $(hostname)" analyst@mydomain.com
	echo -e "$msg" | mail -s "Archivos Modificados en $(hostname)" other@mail.com
else
	echo "NO se han modificado los archivos"
fi

exit 0
