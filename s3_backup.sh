#!/bin/bash

S3_BUCKET="jeeva-ass"
BACKUP_DIR="/backup"
PG_USER="postgres"  # Update this to the correct PostgreSQL username if necessary

mkdir -p "$BACKUP_DIR"

# Get list of databases using the correct PostgreSQL user
DATABASES=$(psql -U "$PG_USER" -d postgres -t -c "SELECT datname FROM pg_database WHERE datistemplate = false;")

for DB in $DATABASES; do
  TIMESTAMP=$(date +"%Y%m%d%H%M%S")
  DB_DIR="${BACKUP_DIR}/${DB}"
  BACKUP_FILE="${DB_DIR}/${DB}_${TIMESTAMP}.sql.gz"

  mkdir -p "$DB_DIR"

  # Dump the database and upload to S3
  pg_dump -U "$PG_USER" "$DB" | gzip > "$BACKUP_FILE" && aws s3 cp "$BACKUP_FILE" "s3://${S3_BUCKET}/${DB}/"
done
