#!/bin/bash
DESTINATION=$1
PORT=$2
CHAT=$3
# clone Odoo directory
git clone --depth=1 https://github.com/anwer-algawe93/odoo15.git $DESTINATION
rm -rf $DESTINATION/.git
# set permission
mkdir -p $DESTINATION/postgresql
chmod -R 777 $DESTINATION
# config
if grep -qF "fs.inotify.max_user_watches" /etc/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | tee -a /etc/sysctl.conf; fi
sysctl -p
sed -i 's/10015/'$PORT'/g' $DESTINATION/docker-compose.yml
sed -i 's/20015/'$CHAT'/g' $DESTINATION/docker-compose.yml
# run Odoo
docker-compose -f $DESTINATION/docker-compose.yml up -d

echo 'Started Odoo @ http://localhost:'$PORT' | Master Password: Anwer@Anwer355 | Live chat port: '$CHAT
