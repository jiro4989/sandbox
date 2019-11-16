#!/bin/bash

set -eu

docker exec -it db_mysql_1 bash -c "mysql -u root -proot chat < /$1"
