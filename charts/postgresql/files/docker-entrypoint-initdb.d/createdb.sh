
#!/bin/bash

# SPDX-License-Identifier: Apache-2.0

echo "Copying ENV variables into temp file..."
export USER= 'hppoc'
export DATABASE= 'fabricexplorer'
export PASSWD= 'password'

echo "USER=${USER}"
echo "DATABASE=${DATABASE}"
echo "PASSWD=${PASSWD}"
if [ -f /tmp/process.env.json ] ; then
    rm /tmp/process.env.json
fi
echo "Executing SQL scripts, OS="$OSTYPE

#support for OS
case $OSTYPE in



darwin*) psql postgres -d fabricexplorer -U hppoc -h localhost -f ./explorerpg.sql ;
psql postgres -d fabricexplorer -U hppoc -h localhost -f ./updatepg.sql ;;
linux*)
if [ $(id -un) = 'postgres' ]; then
  PSQL="psql"
else
  PSQL="sudo -u postgres psql"
fi;
${PSQL} -d fabricexplorer -U hppoc -h localhost -f ./explorerpg.sql ;
${PSQL} -d fabricexplorer -U hppoc -h localhost -f ./updatepg.sql ;;
esac
