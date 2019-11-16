#!/bin/bash

set -eu

docker exec -it db_mysql_1 mysql -u root -proot chat
