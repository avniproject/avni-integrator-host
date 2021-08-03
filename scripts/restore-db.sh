sudo -u $2 psql postgres -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'bahmni_avni' AND pid <> pg_backend_pid()"
sudo -u $2 psql postgres -c 'drop database bahmni_avni'
sudo -u $2 psql postgres -c "create user bahmni_avni_admin with password 'password'"
sudo -u $2 psql postgres -c 'create database bahmni_avni with owner bahmni_avni_admin'
sudo -u $2 psql bahmni_avni -f $1
