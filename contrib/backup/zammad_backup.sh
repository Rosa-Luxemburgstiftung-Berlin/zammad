#!/usr/bin/env bash
#
# zammad backup script
#

# shellcheck disable=SC2046
BACKUP_SCRIPT_PATH="$(dirname $(realpath $0))"

# import functions
. ${BACKUP_SCRIPT_PATH}/functions

while getopts h?D:H:F:T:E:d opt; do
  case $opt in
    h|\?)
      help
      exit 0
      ;;
    D)
      BACKUP_DIR="$OPTARG"
      ;;
    H)
      HOLD_DAYS="$OPTARG"
      ;;
    F)
      FULL_FS_DUMP="$OPTARG"
      ;;
    T)
      TAR_ZIP_ARG="$OPTARG"
      ;;
    E)
      TAR_FILE_EXT="$OPTARG"
      ;;
    d)
      DEBUG='yes'
      ;;
    *)
      echo "unhandled opt: $opt"
      help
      exit 1
  esac
done

# ensure we have all options
demand_backup_conf

# exec backup
start_backup_message

get_zammad_dir

check_database_config_exists

check_empty_password

get_backup_date

backup_dir_create

backup_file_write_test

delete_old_backups

backup_files

backup_db

backup_chmod_dump_data

finished_backup_message
