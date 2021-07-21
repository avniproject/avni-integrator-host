#!/usr/bin/env bash
# Generated files: start-ab-integrator.sh
set -e

if [[ $(id -u) -ne 0 ]] ; then echo "root/sudo privileges required" ; exit 1 ; fi

START_AB_I=./start-ab-integrator.sh
SERVICE=abi.service

create_dirs() {
    if [[ ! -e logs ]]; then
        mkdir logs
    fi
}

create_dirs

read -p "BUGSNAG_API_KEY=" BUGSNAG_API_KEY
read -p "AVNI_API_PASSWORD=" AVNI_API_PASSWORD
read -p "BAHMNI_OPENMRS_API_PASSWORD=" BAHMNI_OPENMRS_API_PASSWORD

echo "#!/bin/bash
export BUGSNAG_API_KEY=${BUGSNAG_API_KEY}
export AVNI_API_PASSWORD=${AVNI_API_PASSWORD}
export BAHMNI_OPENMRS_API_PASSWORD=${BAHMNI_OPENMRS_API_PASSWORD}
export AVNI_API_URL=https://app.avniproject.org
export AVNI_API_USER=avni-to-bahmni@ashwini
export BAHMNI_OPENMRS_API_URL=http://localhost:8050
export BAHMNI_OPENMRS_API_USER=avni_integration_txdata_admin
export INT_SCHEDULE_CRON=0 0 1 * * ?
export INT_APP_TASKS=AvniSubject,AvniEnrolment,AvniProgramEncounter
export INT_DB_NAME=bahmni_avni
/usr/java/jdk-15.0.2+7/bin/java -jar integrator-0.0.1-SNAPSHOT.jar" > ${START_AB_I}
chmod 755 ${START_AB_I}
chown -R bahmni:bahmni ${START_AB_I}
echo "Generated ${START_AB_I} ..."

cp ./abi.service /etc/systemd/system/
echo "Created /etc/systemd/system/abi.service ..."

echo "systemctl daemon-reload ..."
systemctl daemon-reload
systemctl enable abi.service
