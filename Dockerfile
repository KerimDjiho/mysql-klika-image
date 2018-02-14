# Povlaci Ubuntu 16.04 image sa Docker Hub-a da koristi kao base image
FROM ubuntu:16.04

# Radi update servera unutar containera i instalira mariadb-client i mariadb-server pakete
RUN apt-get update && apt-get install mariadb-client mariadb-server -y


# Kreira direktorij koji ce pokrenuti setup baze
RUN mkdir /docker-entrypoint-init.d

# Prebacuje schemu koju sam kreirao u direktorij kreiran iznad
ADD ./klikaSchema.sql /docker-entrypoint-init.d

# Prebacuje skriptu za podesavanje MySQL-a
ADD ./mysqlDatabase.sh /docker-entrypoint-init.d

#Otkriva port
EXPOSE 3306

# Pokrece mysql server, a Dockerfile-ovi nemaju direktnu podrsku za startanje
# servisa. Rijesenje je da otvorimo bash sesiju, a to sprijecava da container "umre" odmah nakon pokretanja
ENTRYPOINT service mysql start && /bin/bash

# Daje execute privilegije na mysqlDatabase.sh skriptu
RUN chmod +x /docker-entrypoint-init.d/mysqlDatabase.sh
