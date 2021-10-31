# SQL Training inspired by book "SQL Questions" Xhoni Shollaj
# powered by Postgresql & PgAdmin & docker-compose


## Requirements:
* docker 
* docker-compose

## Quick Start
* Clone or download this repository
* Go inside of directory,  `cd sql_training`
* Run this command `docker-compose up -d`

## Environments
This Compose file contains the following environment variables:

* `POSTGRES_USER` the default value is **admin**
* `POSTGRES_PASSWORD` the default value is **admin**
* `PGADMIN_PORT` the default value is **5050**
* `PGADMIN_DEFAULT_EMAIL` the default value is **admin@admin.com**
* `PGADMIN_DEFAULT_PASSWORD` the default value is **admin**

## Access to postgres: 
* `localhost:5432`
* **Username:** admin (as a default)
* **Password:** admin (as a default)

## Access to PgAdmin: 
* **URL:** `http://localhost:5050`
* **Username:** admin@admin.com (as a default)
* **Password:** admin (as a default)

