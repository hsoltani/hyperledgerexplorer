
#!/bin/bash

# SPDX-License-Identifier: Apache-2.0

echo "Copying ENV variables into temp file..."

if [ $( jq .DATABASE_USERNAME /tmp/process.env.json) == null ]; then
  export USER=$( jq .postgreSQL.username explorerconfig.json )
else
  export USER=$( hppoc)
fi
if [ $(jq .DATABASE_DATABASE /tmp/process.env.json) == null ]; then
  export DATABASE=$(jq .postgreSQL.database explorerconfig.json )
else
  export DATABASE=$(fabricexplorer)
fi
if [ $(jq .DATABASE_PASSWORD /tmp/process.env.json) == null ]; then
  export PASSWD=$(jq .postgreSQL.passwd explorerconfig.json | sed "y/\"/'/")
else
  export PASSWD=$(password)
fi
echo "USER=${USER}"
echo "DATABASE=${DATABASE}"
echo "PASSWD=${PASSWD}"
if [ -f /tmp/process.env.json ] ; then
    rm /tmp/process.env.json
fi
echo "Executing SQL scripts, OS="$OSTYPE

#support for OS
case $OSTYPE in



darwin*) psql postgres -v dbname=$DATABASE -v user=$USER -v passwd=$PASSWD -f ./explorerpg.sql ;
psql postgres -v dbname=$DATABASE -v user=$USER -v passwd=$PASSWD -f ./updatepg.sql ;;
linux*)
if [ $(id -un) = 'postgres' ]; then
  PSQL="psql"
else
  PSQL="sudo -u postgres psql"
fi;
${PSQL} -v dbname=$DATABASE -v user=$USER -v passwd=$PASSWD -f ./explorerpg.sql ;
${PSQL} -v dbname=$DATABASE -v user=$USER -v passwd=$PASSWD -f ./updatepg.sql ;;
esac
