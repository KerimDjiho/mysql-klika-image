#!/bin/bash

mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RootKlikaPass'"
mysql -u root -e "CREATE DATABASE Klika"
mysql -u root $MYSQL_DATABASE < /docker-entrypoint-init.d/klikaSchema.sql