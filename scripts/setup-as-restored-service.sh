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

chmod 755 ${START_AB_I}
echo "Generated ${START_AB_I} ..."

cp ./abi.service /etc/systemd/system/
echo "Created /etc/systemd/system/abi.service ..."

echo "systemctl daemon-reload ..."
systemctl daemon-reload
systemctl enable abi.service
