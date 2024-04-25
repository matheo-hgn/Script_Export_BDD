#!/bin/bash

echo "Quel est l'adresse ip du serveur ? :"
read DB_HOST

echo "Quel est le Nom d'utilisateur a utiliser ? :"
read DB_USER

echo "Quel est le mot de passe a utiliser ? :"
read -s  DB_PASS

echo "Quel est le nom de la base de données ? :"
read DB_NAME

echo "Quel nom voulez vous donnez a l'export ? :"
read EXPORT

DATE=$(date +"%d-%m-%Y")

NM_EXPORT="$DATE"_"$EXPORT".sql

echo "1. Créer un dossier pour la sauvegarde /n2. Utiliser un dossier existant "
read -r choix

if [ "$choix" = "1"]; then
    echo "Quel est le chemin du dossier (Entrer un chemin)"
    read FOLDER

    if [ -z "$FOLDER"]; then
    	echo "chemin invalide, Le dossier ne peut être crée"
    fi

    sudo mkdir -p "$FOLDER"

    if [ $FOLDER -eq 0 ]; then
    	echo "Le dossier a était créé avec succés dans : $FOLDER "
    else
    	echo "le fichier n'a pas pu être crée"
    fi


elif ["$choix" = "2"]; then
    echo "Quel est la racine du dossier existant ? :"
    read FOLDER

    if [ -z "$FOLDER" ]; then
	echo "Chemin invalide, merci de rentrer un chemin existant"
    fi

fi


DATE=$(date +"%d-%m-%Y")

NM_EXPORT="$DATE"_"$EXPORT".sql



mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$FOLDER"



if [[ -f "$FOLDER/$NM_EXPORT"]]; then
    echo "La base de donnée $DB_NAME a été exporter avec succès "
else
    echo "une erreur est intervenu dans l'export de la base de données"
fi

