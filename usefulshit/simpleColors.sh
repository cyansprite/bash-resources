for (( i = 0; i < 8; i++ )); do
    echo -en "$(tput setab $i)       $(tput sgr0) $(tput setaf $i) a small sentence, color : $i $(tput sgr0)"
    echo
done
echo

for (( i = 8; i < 16; i++ )); do
    echo -en "$(tput setab $i)       $(tput sgr0) $(tput setaf $i) a small sentence, color : $i $(tput sgr0)"
    echo
done
echo
