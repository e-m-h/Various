#!/usr/bin/env bash

# Use innoextract to unpackage GOG games while removing extraneous files (e.g. DOSBox)
# Create appropriate directory using GOG ID (maybe capitalize and truncate to 8 characters)

# innoextract --exclude-temp

unset -f command

GAMEARCHIVE=${1}
EXDIR=${EXDIR:-${PWD}}

innoextractCheck() {
	if [[ $(command -v innoextract) ]]; then
		printf "Innoextract found.\n"
		:
	else
		case $(uname -s) in
			Darwin)
				printf "Using Mac, checking for Brew...\n";
#					if [[ $(command -v brew) ]]; then 
#						brew install innoextract
#					else
#						printf "Homebrew not found. Install Homebrew and then innoextract? "; read -r YN
#							case ${YN} in
#								Y|y|"")
#									/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#									;;
#								N|n)
#									exit 1
#									;;		
#					fi
				;;
			Linux)
#				More please
				;;		
		esac
	fi
}

extractFiles() {
	innoextract --exclude-temp ${GAMEARCHIVE} -d ${EXDIR}
#	rm -rf ${EXDIR}/commonappdata	
}

removeFiles() {
	printf "Removing extraneous files from %s/ \(commonappdata and DOSBox/GOG files\). Continue?\n" ${EXDIR}; read -r YN
		case ${YN} in
			Y|y|"")
				rm -rfv ${EXDIR}/commonappdata;
				find ${EXDIR} -iname "*dosbox*"
				;;
			N|n)
				printf "Exiting.\n"
				exit 1
				;;
		esac
}

innoextractCheck
extractFiles 
removeFiles

#	rm -rf commonappdata
printf "After function\n"
