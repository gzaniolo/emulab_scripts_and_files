



cd $HOME

sudo apt install openjdk-21-jdk

# https://github.com/cmu-db/benchbase
git clone --depth 1 https://github.com/cmu-db/benchbase.git
cd benchbase
./mvnw clean package -P postgres
cd target && 
tar xvzf benchbase-postgres.tgz

cp $HOME/emulab_scripts_and_files/sample_tpcc_config_2.xml $HOME/benchbase/target/benchbase-postgres/config/postgres/sample_tpcc_config_2.xml



