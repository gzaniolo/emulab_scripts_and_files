sudo apt update
sudo apt install -y openjdk-21-jdk

cd $HOME
# https://github.com/cmu-db/benchbase
# git clone --depth 1 https://github.com/cmu-db/benchbase.git

# cd benchbase
# ./mvnw clean package -P postgres

# cd target && 
# tar xvzf benchbase-postgres.tgz

sudo cp $HOME/emulab_scripts_and_files/sample_tpcc_config_single_pgb.xml /proj/cmu712/benchbase/target/benchbase-postgres/config/postgres/sample_tpcc_config_single_pgb.xml
sudo cp $HOME/emulab_scripts_and_files/sample_tpcc_config_multi.xml /proj/cmu712/benchbase/target/benchbase-postgres/config/postgres/sample_tpcc_config_multi.xml
sudo cp $HOME/emulab_scripts_and_files/sample_tpcc_config_multi_pgb.xml /proj/cmu712/benchbase/target/benchbase-postgres/config/postgres/sample_tpcc_config_multi_pgb.xml



