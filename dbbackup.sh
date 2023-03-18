# A simple shell script for backing up a MariaDB database

CRED_FILE="/root/rdb_cred"
BACKUP_FILE="/root/rdb_backup_"
DATE_FORMAT=$(date +"%d_%m_%Y")
SQL_USER="user"
SQL_DB="database"

mysqldump --defaults-extra-file="${CRED_FILE}" ${SQL_DB} -u ${SQL_USER} > ${BACKUP_FILE}${DATE_FORMAT}

