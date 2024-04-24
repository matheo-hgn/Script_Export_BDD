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


mkdir -p  /var/backup/MYSQL/GLPI

mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > /var/backup/MYSQL/GLPI/"$NM_EXPORT"



if [[ -f /var/backup/MYSQL/GLPI/$NM_EXPORT ]]; then
    echo "La base de donnée $DB_NAME a été exporter avec succès "
else
    echo "une erreur est intervenu dans l'export de la base de données"
fi

