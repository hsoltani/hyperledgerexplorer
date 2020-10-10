#!/bin/sh
mkdir -p /opt/explorer/app/platform/fabric/
mkdir -p /tmp/

mv /opt/explorer/app/platform/fabric/config.json /opt/explorer/app/platform/fabric/config.json.vanilla
cp /data/config.json /opt/explorer/app/platform/fabric/config.json

cd /data
node main.js && tail -f /dev/null
