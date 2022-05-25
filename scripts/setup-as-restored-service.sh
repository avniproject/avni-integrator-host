#!/usr/bin/env bash
set -e

if [[ $(id -u) -ne 0 ]] ; then echo "root/sudo privileges required" ; exit 1 ; fi

START_A_I=./start-avni-integrator.sh
SERVICE=ai.service

create_dirs() {
    if [[ ! -e /var/log/avni-int-service ]]; then
        mkdir /var/log/avni-int-service
    fi
}

create_dirs

chmod 755 ${START_A_I}
echo "Generated ${START_A_I} ..."

cp ./ai.service /etc/systemd/system/
echo "Created /etc/systemd/system/ai.service ..."

echo "systemctl daemon-reload ..."
systemctl daemon-reload
systemctl enable ai.service
