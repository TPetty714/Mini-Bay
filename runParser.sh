#!/bin/bash

python skeleton_parser.py data/items-test.xml
cat item.dat | sort | uniq > item.out
cat bid.dat | sort | uniq > bid.out
cat category.dat | sort | uniq > category.out
cat user.dat | sort | uniq > user.out

sqlite3 data.db < create.sql
sqlite3 data.db < load.txt
sqlite3 data.db < constraint_verify.sql
sqlite3 data.db < Trigger07_add.sql
sqlite3 data.db < Trigger08_add.sql
sqlite3 data.db < Trigger09_add.sql
sqlite3 data.db < Trigger10_add.sql
sqlite3 data.db < Trigger11_add.sql
sqlite3 data.db < Trigger12_add.sql
sqlite3 data.db < Trigger13_add.sql
sqlite3 data.db < Trigger14_add.sql
sqlite3 data.db < Trigger15_add.sql
sqlite3 data.db < test.sql
