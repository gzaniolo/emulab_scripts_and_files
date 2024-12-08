# Some instrs

Instructions on how to get things working in emulab.

These instructions should work in both single machine and multi machine case.

### Single Machine case:

When creating a test for a single machine, use the "test" profile.

### Multi Machine case:

When creating a test where you want to have the database on one machine, the proxy on the second, and the client on the third, use the "new_multi_topo" profile.

## Initialize components

Each of the shell scripts should initialize one of the components. Please run them from inside this directory. 

WARNING: setup_tigger.sh will not work! Do not try to run it! Follow the instructions inside it!

Setup database:\
NOTE: in the multi-machine case, run this on node 0.
```
/bin/bash setup_db.sh
```

Setup pgbouncer:\
NOTE: in the multi-machine case, run this on node 1.
```
/bin/bash setup_pgbouncer.sh
```

Setup benchbase:\
NOTE: in the multi-machine case, run this on node 2.
```
/bin/bash setup_benchbase.sh
```


## Run programs:

## Single Machine

### Pgbouncer
```
pgbouncer single.ini
```
If you get permissions issues, run:
```
sudo chmod 777 /var/run/postgresql/
```

### Run bencbase example - without pgbouncer:
```
cd ~/benchbase/target/benchbase-postgres
java -jar benchbase.jar -b tpcc -c config/postgres/sample_tpcc_config.xml --create=true --load=true --execute=true
```

### Run bencbase example - with pgbouncer:
```
cd ~/benchbase/target/benchbase-postgres
java -jar benchbase.jar -b tpcc -c config/postgres/sample_tpcc_config_single_pgb.xml --create=true --load=true --execute=true
```
Note - sample_tpcc_config_single_pgb.xml is a test that has been modified to target pgbouncer. The default tests go directly to the database.


## Multi Machine

### Pgbouncer
```
pgbouncer multi.ini
```
If you get permissions issues, run:
```
sudo mkdir /var/run/postgresql/
sudo chmod 777 /var/run/postgresql/
```

### Run bencbase example - without pgbouncer:
```
cd ~/benchbase/target/benchbase-postgres
java -jar benchbase.jar -b tpcc -c config/postgres/sample_tpcc_config_multi.xml --create=true --load=true --execute=true
```

### Run bencbase example - with pgbouncer:
```
cd ~/benchbase/target/benchbase-postgres
java -jar benchbase.jar -b tpcc -c config/postgres/sample_tpcc_config_multi_pgb.xml --create=true --load=true --execute=true
```

