#!/bin/bash

# Les entêtes qui vont bien

nomUser=$1
reponse='' # La variable ne sert jamais
codret=0 # codret --> coderet

while [[ -z "$reponse" ]] # Boucle infinie
do
    # test si vide
    if [[ -z $nomUser ]] # "$nomUser" c'est mieux
    then
        echo "Quel utilisateur souhaitez-vous rechercher ?"
        echo " (Merci de saisir le nom exact)"
        read nomUser
        rep = $("cat /etc/passwd/ | grep "$nomUser"") # Ne fonctionnera pas s'il y a plusieurs lignes
        # rep = $(... --> rep=$(...
        # /etc/passwd/ --> /etc/passwd
        # grep "$nomUser" --> grep "^${nomUser}:" (^ = début de ligne et : est le séparateur dans /etc/passwd)
        # grep --> grep -E (inutile ici mais prends en l'habitude)
        # rep=$(cat /etc/passwd | grep -E "^${nomUser}:")
        if [[ -n "$rep" ]]
        then
            echo "nom     :" $("$rep | cut -d ':' -f 1")
            echo "password:" $("$rep | cut -d ':' -f 1") # -f 2
            echo "userId  :" $("$rep | cut -d ':' -f 1") # -f 3
            echo "groupId :" $("$rep | cut -d ':' -f 1") # -f 4
            echo "homeDir :" $("$rep | cut -d ':' -f 1") # -f 6
        fi
    fi
done

echo ""
echo "fin du programme $0"
# fin de programme
exit "$coderet"
