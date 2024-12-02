


sudo apt update
sudo apt install -y libtool
sudo apt install -y libevent-dev
sudo apt install -y pkg-config
sudo apt install -y libssl-dev
sudo apt install -y pandoc

cd $HOME
git clone https://github.com/pgbouncer/pgbouncer.git

cd pgbouncer
./autogen.sh
./configure


make

sudo make install

cd $HOME


# a.ini must be modified to contain your home directory if you want to run it 
#  the way I describe. It probably would have been easier if I just copied it 
#  into /etc/<something...> or wherever it was supposed to go.
replace_auth_file_path() {
  # Arguments
  input_file="$1"
  output_file="$2"

  if [[ ! -f "$input_file" ]]; then
    echo "File $input_file does not exist."
    return 1
  fi

  current_dir=$(pwd)

  sed "s|auth_file = /users/gzaniolo/userlist.txt|auth_file = $current_dir/userlist.txt|" "$input_file" > "$output_file"
}

replace_auth_file_path "$HOME/emulab_scripts_and_files/single.ini" "$HOME/single.ini"
replace_auth_file_path "$HOME/emulab_scripts_and_files/multi.ini" "$HOME/multi.ini"



cp $HOME/emulab_scripts_and_files/userlist.txt $HOME/userlist.txt

sudo mkdir -p /var/run/postgresql

sudo chmod 777 /var/run/postgresql

# You eventually run pgbouncer from your home directory with:
# pgbouncer a.ini
