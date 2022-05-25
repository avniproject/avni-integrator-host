#!/usr/bin/env bash
# Generated files: start-avni-integrator.sh
set -e

if [[ $(id -u) -ne 0 ]] ; then echo "root/sudo privileges required" ; exit 1 ; fi

START_A_I=./start-avni-integrator.sh
SERVICE=ai.service

create_dirs() {
    if [[ ! -e /var/log/abi ]]; then
        mkdir /var/log/avni-int-service
    fi
}

create_dirs


echo "#!/bin/bash
# Change to JDK 17
#/usr/java/jdk-15.0.2+7/bin/java --enable-preview -jar -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=6031 integrator-0.0.1-SNAPSHOT.jar
/usr/java/jdk-15.0.2+7/bin/java --enable-preview -jar integrator-0.0.1-SNAPSHOT.jar" > ${START_AB_I}
chmod 755 ${START_A_I}
echo "Generated ${START_A_I} ..."

cp ./abi.service /etc/systemd/system/
echo "Created /etc/systemd/system/ai.service ..."

echo "systemctl daemon-reload ..."
systemctl daemon-reload
systemctl enable abi.service
