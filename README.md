# Statera Energy Data Engineer Technical Assessment

Welcome to the Data Engineer interview repo! The fact that you've got this far suggests you're doing well!

# Getting Started

You'll need Docker installed. Installing it is beyond the scope of this README,
but if you're having trouble please reach out to your Statera contact.

Once docker is installed, you can start the database by doing:

```bash
docker compose up
```

If all has gone according to plan you should now see a low-fi db admin page at `localhost:8080`.

To access the database, choose "PostgreSQL" as the system, "db" as the server and:

- username: `postgres`
- password: `type-whatever-you-want-here`
- database: `postgres`


You can also connect to the database using your favourite client (we sometimes
use DBeaver) with the following credentials:

- host: `localhost`
- port: 15432
- user: `postgres`
- password: leave this blank
- database: `postgres`
