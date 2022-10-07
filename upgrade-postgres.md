## Postgres upgrade steps

Steps to upgrade the postgres version for your local environment. The steps below show going from version 10 to 11 so replace with other version numbers in the future

- Stop all local processes which access the database (servers, workers)

- Drop the local database (`rake db:drop`)

- Stop current running version of postgres (`brew services stop postgresql@10`)

- Install new postgres version with homebrew (`brew install postgresql@11`)

- Uninstall prior version of postgres (`brew uninstall postgresql@10`) and remove the data files from /usr/local/var/postgres@10

- Start the new version of postgres (`brew services start postgresql@11`)

- Add the following to .zshrc to add postgres@11 to your PATH, according to the homebrew instructions. Then run: `source ~/.zshrc`
```
export PATH="/opt/homebrew/opt/postgresql@11/bin:$PATH"
```

- Set up the new database instance:
```
createdb
createuser -s postgres
```

- For Rails projects, uninstall and reinstall the pg gem:
```
gem uninstall pg
bundle
```

- For Rails projects, reconstruct project databases:
```
rake db:create
rake db:migrate
```
