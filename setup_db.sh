



sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql  # This will ensure PostgreSQL starts on boot
sudo systemctl status postgresql


sudo -i -u postgres psql -c "CREATE USER admin WITH PASSWORD 'password';"
sudo -i -u postgres psql -c "CREATE DATABASE benchbase;"
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE benchbase TO admin;"

# TODO change the files
sudo cp $HOME/emulab_scripts_and_files/postgresql.conf /etc/postgresql/14/main/postgresql.conf 

sudo cp $HOME/emulab_scripts_and_files/pg_hba.conf /etc/postgresql/14/main/pg_hba.conf 

echo "exit, log back in, and 'systemctl restart postgresql'"

sudo systemctl restart postgresql





