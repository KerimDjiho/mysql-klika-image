#!/bin/bash

mysql -u root -e "CREATE DATABASE Klika"
mysql -u root Klika < /docker-entrypoint-init.d/klikaSchema.sql
mysql -u root -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'WordKlikaPass'"
mysql -u root -e "CREATE USER 'wordpress'@'%' IDENTIFIED BY 'WordKlikaPass'"
mysql -u root -e "GRANT ALL PRIVILEGES ON Klika.* TO 'wordpress'@'localhost'"
mysql -u root -e "GRANT ALL PRIVILEGES ON Klika.* TO 'wordpress'@'%'"
mysql -u root -e "FLUSH PRIVILEGES"
echo "[mysqld]" >> /etc/mysql/my.cnf
echo "bind-address = 0.0.0.0" >> /etc/mysql/my.cnf
service mysql restart
