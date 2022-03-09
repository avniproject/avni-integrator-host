#!/usr/bin/env bash
# Generated files: start-ab-integrator.sh
set -e

if [[ $(id -u) -ne 0 ]] ; then echo "root/sudo privileges required" ; exit 1 ; fi

START_AB_I=./start-ab-integrator.sh
SERVICE=abi.service

create_dirs() {
    if [[ ! -e /var/log/abi ]]; then
        mkdir /var/log/abi
    fi
}

create_dirs


echo "#!/bin/bash
#/usr/java/jdk-15.0.2+7/bin/java --enable-preview -jar -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=6031 integrator-0.0.1-SNAPSHOT.jar
/usr/java/jdk-15.0.2+7/bin/java --enable-preview -jar integrator-0.0.1-SNAPSHOT.jar" > ${START_AB_I}
chmod 755 ${START_AB_I}
echo "Generated ${START_AB_I} ..."

cp ./abi.service /etc/systemd/system/
echo "Created /etc/systemd/system/abi.service ..."

echo "systemctl daemon-reload ..."
systemctl daemon-reload
systemctl enable abi.service
