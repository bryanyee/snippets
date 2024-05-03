## Save and restore a postgres db from a dump file

### List database names
Terminal:
```
psql
```
In psql console:
```
\l
```

### Save a copy of the database to a dump file
```
pg_dump -U <username> -W -F c -b -v -f <file_path> <db_name>

// example:
pg_dump -U postgres -W -F c -b -v -f db_copy.pgsql development_database
```
Flags:
- `-U <username>`: Username
- `-W`: Prompts for password
- `-F c`: Creates a custom-format archive suitable for input into pg_restore
- `-b`: Includes large objects in the dump
- `-v`: Enables verbose mode, providing more information during the dump process
- `-f <file_path>`: Specifies the path to the output file where the dump will be saved
- `<db_name>`: The name of the database to dump

### Restore database from a dump file
Drop the existing database if needed. Below is for a Rails app:
```
rails db:drop
rails db:create
```
Restore the db:
```
pg_restore -d  <db_name> <file_path>

// example:
pg_restore -d  development_database db_copy.pgsql
```
