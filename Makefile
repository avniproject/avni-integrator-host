postgres_user := $(shell id -un)
ifeq ('$(postgres_user)', 'root')
	postgres_user='postgres'
endif

foo:
	@echo $(postgres_user)

tunnel-mysql-vagrant:
	ssh -p 2222 -i ~/.vagrant.d/insecure_private_key vagrant@127.0.0.1 -L 6032:localhost:3306

restore-backup-from-vagrant:
	scp -P 2222 -i ~/.vagrant.d/insecure_private_key root@127.0.0.1:/root/source/abi-host/backup/backup.sql /tmp/abi-backup.sql

restore-remote-backup:
	sh scripts/restore-db.sh backup/remote-backup.sql $(postgres_user)

backup-db:
	sh scripts/backup-db.sh

copy-backup-on-vagrant:
	scp -P 2222 -i ~/.vagrant.d/insecure_private_key backup/backup.sql root@127.0.0.1:/root/source/abi-host/backup/remote-backup.sql
