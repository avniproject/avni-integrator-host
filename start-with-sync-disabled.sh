#!/bin/bash
export BUGSNAG_API_KEY=d1bd712327b35aaed2cd090580d29296
export INT_APP_FIRST_RUN=false
export INT_SCHEDULE_CRON="0 0 6 6 9 ? 2035"
export INT_APP_TASKS=
export INT_DB_NAME=bahmni_avni
/usr/java/jdk-15.0.2+7/bin/java --enable-preview -jar integrator-0.0.1-SNAPSHOT.jar
