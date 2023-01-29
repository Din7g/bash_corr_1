#!/bin/bash

# Les entêtes qui vont bien
# Le programme
# - Demande à l'utilisateur le numéro de colonne à séléctionner
# - Si le numéro de colonne est 3 ou 4, trier le résultat numériquement en sens inverse
# - Boucle tant que l'utilisateur n'a pas entré une chaîne vide

# Constantes

# Variables
coderet=0

# Fonctions
function f_demander_colonne()
{
    # local reponse # Pour créer une variable locale (inutile ici car on la veut globale)
    # local mavariable1="toto"
    # local mavariable2=
    # local mavariable3
    # local monargument1=$1
    # local nbArgumentsPassesAMaFonction=$# # Arguments passé a la fonction ! pas au script ! seul le $0 (le nom du programme) reste global
    echo "Quel numéro de colonne souhaitez-vous séléctionner ?"
    read reponse # Les variables sont toujours globales sauf si on avait eu une ligne "local reponse"
}

function f_recuperer_colonne()
{
    local numero_colonne=$1 # $numero_colonne vaudra donc $reponse
    if [[ $numero_colonne -eq 3 ]] || [[ $numero_colonne -eq 4 ]]
    # Ecriture alternative 1:
    # if [[ $numero_colonne -eq 3 || $numero_colonne -eq 4 ]]
    # Ecriture alternative 2:
    # if (( $numero_colonne == 3 || $numero_colonne == 4 ))
    # Ecriture alternative 3:
    # if (( numero_colonne == 3 || numero_colonne == 4 ))
    then
        cat /etc/passwd | cut -d ':' -f "$numero_colonne" | sort -r -n # -r: inverserver le tri, -n: tri numérique
    else
        cat /etc/passwd | cut -d ':' -f "$numero_colonne"
        # Ecriture alternative:
        # cut /etc/passwd -d ':' -f "$numero_colonne"
    fi
}

# Programme principal
f_demander_colonne
while [[ -n "$reponse" ]] # Tant que $reponse contient qqch
do
    # si $reponse est nombre (nul ou positif), puis si $réponse est un nombre entre 1 et 7
    if [[ "$reponse" =~ ^[0-9]+$ ]] && [[ "$reponse" -ge 1 ]] && [[ "$reponse" -le 7 ]]
    # Ecriture alternative 1 :
    # if [[ "$reponse" =~ ^[0-9]+$ ]] && (( $reponse >= 1 && $reponse <= 7 ))
    # Ecriture alternative 2 (les $ sont implicites dans les ((...)) ):
    # if [[ "$reponse" =~ ^[0-9]+$ ]] && (( reponse >= 1 && reponse <= 7 ))
    then
        # ! Les arguments de fonctions sont passés de la même manière que pour les programmes, donc séparés par des espaces
        # Exemple: f_recuperer_colonne("$reponse") est INCORRECT
        f_recuperer_colonne "$reponse" # $reponse se récupérera dans la fonction par sa variable (locale) $1
    else
        echo "L'entrée doit être un nombre entre 1 et 7" >&2 # >&2 = Rediriger (>) vers la sortie d'erreur (&2)
    fi
    echo ""
    f_demander_colonne
done

echo ""
echo "fin du programme $0"
# fin de programme
exit "$coderet"
