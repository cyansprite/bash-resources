for (( i = 0; i < 8; i++ ))
    do echo -en "$(tput setaf $i) xX $(tput setab $i)    $(tput sgr0)"
done
echo

for (( i = 8; i < 16; i++ ))
    do echo -en "$(tput setaf $i) xX $(tput setab $i)    $(tput sgr0)"
done
echo
