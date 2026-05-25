#!/usr/bin/env bash
#
# zammad backup script
#

# shellcheck disable=SC2046
BACKUP_SCRIPT_PATH="$(dirname $(realpath $0))"

# import functions
. ${BACKUP_SCRIPT_PATH}/functions

# ensure we have all options
demand_backup_conf

# exec backup
start_backup_message

pre_backup_exec

get_zammad_dir

check_database_config_exists

check_empty_password

get_backup_date

backup_dir_create

backup_file_write_test

delete_old_backups

pre_db_backup_exec

backup_db

pre_files_backup_exec

backup_files

backup_chmod_dump_data

post_backup_exec

finished_backup_message
