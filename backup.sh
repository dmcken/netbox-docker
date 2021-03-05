#!/bin/bash

backupdir=./backups
timestamp=`date +"%Y%m%d-%H%M%S"`

mkdir -p $backupdir

#echo "Dumping database"
docker-compose exec -T postgres sh -c 'pg_dump -cU $POSTGRES_USER $POSTGRES_DB' | bzip2 -c > $backupdir/netbox-db-$timestamp.sql.bz2
#echo "Dumping media"
docker-compose exec -T netbox   tar c -jf - -C /opt/netbox/netbox/media ./                 > $backupdir/netbox-media-$timestamp.tar.bz2
