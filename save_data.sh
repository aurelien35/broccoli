#!/bin/bash

set -o errexit
set -o pipefail

echo ""
echo ""
echo ""

echo "#"
echo "#"
echo "#  Preparation de la sauvegarde..."
echo "#"
echo "#"


rm -rf /var/broccoli.save/tmp
mkdir -p /var/broccoli.save/tmp


echo "#"
echo "#"
echo "#  Sauvegarde des configurations nginx..."
echo "#"
echo "#"


mkdir -p /var/broccoli.save/tmp/nginx/sites
cp -a /home/dockeruser/broccoli/nginx/volumes/configuration/sites/*.conf /var/broccoli.save/tmp/nginx/sites

pushd /var/broccoli > /dev/null

    for i in * ; do
        if [ -d "$i" ]; then

            echo "#"
            echo "#"
            echo "#  Sauvegarde du site $i..."

            if [ -d "$i/mattermost" ]; then
                echo "#      Sauvegarde de la configuration mattermost..."
                mkdir -p /var/broccoli.save/tmp/$i/mattermost/config
                cp -a /var/broccoli/$i/mattermost/app/mattermost/config/config.json /var/broccoli.save/tmp/$i/mattermost/config/config.json
				
                echo "#      Sauvegarde des donnees mattermost..."
                cp -a /var/broccoli/$i/mattermost/app/mattermost/data /var/broccoli.save/tmp/$i/mattermost
				
                echo "#      Sauvegarde de la base de donnees mattermost..."
				docker exec $i-mattermost-db pg_dump --host=127.0.0.1 --dbname=mattermost --username=mmuser --clean --create > /var/broccoli.save/tmp/$i/mattermost/database.dump
            fi
			
            echo "#"
            echo "#"
        fi
    done

popd > /dev/null


echo "#"
echo "#"
echo "#  Creation de l'archive..."
echo "#"
echo "#"


7zr a -r /var/broccoli.save/broccoli.save.$(date +"%Y-%m-%d.%Hh%M").7z /var/broccoli.save/tmp/* > /dev/null
rm -rf /var/broccoli.save/tmp

echo ""
echo ""
echo ""

