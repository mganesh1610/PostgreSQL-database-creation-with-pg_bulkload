# Time Tracker
SECONDS=0

# Stop if any error
set -e

# Necessary software check
#if ! command -v psql &> /dev/null; then
#  echo "PostgreSQL is not there. Installing it..."
#  sudo apt-get update
#  sudo apt-get install -y postgresql-14 postgresql-contrib-14 libpq-dev
#fi

#if ! command -v pg_bulkload &> /dev/null; then
#  echo "pg_bulkload is not available. Installing it..."
#  sudo apt-get install -y pg-bulkload
#fi

# Start PostgreSQL service
echo "Starting PostgreSQL"
sudo service postgresql start

# PostgreSQL connection details
DB_NAME="postgres"
DB_USER="postgres"
DB_PASS="postgres"
DB_HOST="127.0.0.1"
DB_PORT="5432"

# password authentication
export PGPASSWORD="$DB_PASS"

# Run SQL scripts to create tables
echo "Running create_table.sql file"
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f create_tables.sql

# Generate control files for pg_bulkload
echo "Creating control files for pg_bulkload..."

cat <<EOF > load_authors.ctl
OUTPUT = public.authors
INPUT = authors.csv
TYPE = CSV
SKIP = 1
DELIMITER =","
QUOTE = "\""
ESCAPE ="\""
NULL =""
TRUNCATE = YES
EOF

cat <<EOF > load_subreddits.ctl
INPUT = subreddits.csv
OUTPUT = public.subreddits
TYPE = CSV
SKIP = 1
DELIMITER =","
QUOTE = "\""
ESCAPE ="\""
NULL =""
TRUNCATE = YES
EOF

cat <<EOF > load_submissions.ctl
OUTPUT = public.submissions
INPUT = submissions.csv
TYPE = CSV
SKIP = 1
DELIMITER =","
QUOTE = "\""
ESCAPE ="\""
NULL =""
TRUNCATE = YES
EOF

cat <<EOF > load_comments.ctl
OUTPUT = public.comments
INPUT = comments.csv
TYPE = CSV
SKIP = 1
DELIMITER =","
QUOTE = "\""
ESCAPE ="\""
NULL =""
TRUNCATE = YES
EOF

# Run pg_bulkload for each table
echo "Loading data using pg_bulkload..."
pg_bulkload -d "$DB_NAME" -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" load_authors.ctl
pg_bulkload -d "$DB_NAME" -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" load_subreddits.ctl
pg_bulkload -d "$DB_NAME" -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" load_submissions.ctl
pg_bulkload -d "$DB_NAME" -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" load_comments.ctl

# Calling relations.sql file
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f create_relations.sql

# Calling queries.sql file
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f queries.sql

echo "completed successfully in $SECONDS seconds."