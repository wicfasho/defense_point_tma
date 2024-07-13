![Logo](/lucee/web/www/app.tma/assets/images/logo.svg)

# Task Management Application

This is a Task Management Application built using ColdFusion (Lucee), MySQL, and Docker. It allows users to create, read, update, and delete tasks. It also includes user authentication. The default username and password is `defensepoint`. CF's `hash` inbuilt function was used to hash password. We may need to update how password are hashed and salted in real life applications. Made it simple because of the time constraint.
I used the MVC pattern to keep things organized.

![Screenshot Auth Page](/lucee/web/www/app.tma/assets/images/ss1.png)

![Screenshot Login Page](/lucee/web/www/app.tma/assets/images/ss2.png)


## Project Structure

```plaintext
defense_point_tma/
├── compose.yml
├── env/
│   ├── global.env
│   ├── mysql.env
│   ├── phpmyadmin.env
├── lucee/
│   ├── Dockerfile
│   ├── nginx/
│   │   ├── default.conf
│   │   ├── nginx.conf
│   ├── web/
│   │   ├── www/
│   │   │   ├── index.cfm
│   │   │   ├── app.tma/
│   │   │   │   ├── application.cfc
│   │   │   │   ├── index.cfm
│   │   │   │   ├── controller/
│   │   │   │   │   ├── AuthController.cfc
│   │   │   │   │   ├── TaskController.cfc
│   │   │   │   ├── model/
│   │   │   │   │   ├── AuthService.cfc
│   │   │   │   │   ├── TaskService.cfc
│   │   │   │   ├── view/
│   │   │   │   │   ├── auth/
│   │   │   │   │   │   ├── login.cfm
│   │   │   │   │   ├── tasks/
│   │   │   │   │   │   ├── list.cfm
│   │   │   │   │   ├── includes/
│   │   │   │   │   │   ├── header.cfm
│   │   │   │   │   │   ├── footer.cfm
│   │   │   │   ├── assets/
│   │   │   │   │   ├── images/
│   │   │   │   │   │   ├── logo.svg
│   │   │   ├── mysql/
│   │   │   │   ├── schema.sql
├── mysql/
│   ├── Dockerfile
│   ├── etc/
│   │   ├── my.conf
│   ├── schema.sql
├── phpmyadmin/
│   ├── Dockerfile
│   ├── ports.conf
│   ├── etc/
│   │   ├── ports.conf
│   │   ├── config.user.inc.php
│   │   ├── apache2/
│   │   │   ├── servername.conf
├── secrets/
│   ├── db_password.txt
│   ├── db_root_password.txt
│   ├── lucee_server_password.txt
```

## Prerequisites

You would need to have docker and docker compose installed on your system:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

! No Docker?: You can copy the files in `/web/www/app.tma` to your own CF root directory. Then set up a datasource and mysql database (the schema is in the mysql folder).

* I removed the env and secrets from the .gitignore to allow you run the application off the shelf. For production ready applications, envs and secrets would be exempted from the git repo.

## Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/wicfasho/defense_point_tma
cd defense_point_tma
```

### 2. Start the Docker Containers

Run the the docker command to start all the services:

```bash
docker-compose up
```

### 4. Access the Application

- Task Management Application: [http://localhost:80](http://localhost:80)
- Lucee Web Server: [http://localhost:9999/lucee/admin/web.cfm](http://localhost:9999/lucee/admin/web.cfm)
- phpMyAdmin: [http://localhost:99](http://localhost:99)

### 5. Initialize the Database

The database schema will be automatically initialized using the `schema.sql` file. You can verify the tables and data using phpMyAdmin. This is handled by CF onApplicationStart() `application.cfc`

### 6. Application Structure

- **Lucee Server**: The application code resides in the `lucee/web/www/app.tma` directory.
- **MySQL**: The database schema is defined in `mysql/schema.sql`.
- **phpMyAdmin**: Configuration files are in the `phpmyadmin/etc` directory.

### 7. Stopping the Containers

To stop the running containers, execute:

```bash
docker-compose down
```

## Additional Notes

- Ensure that the `secrets` directory contains the necessary password files.
- Modify the `compose.yml` file if you need to change any service configurations or ports.

## Troubleshooting

- **Database Connection Issues**: Ensure the MySQL service is running and the credentials in `mysql.env` are correct.
- **Service Unavailable**: Check the Docker logs for any errors using `docker-compose logs`.

## Issues Running the Code

Please if you face any issue trying to run the code, you can reach me via mail [Wesley] at [eclogue_western0t@icloud.com].
