


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
input_file="$HOME/emulab_scripts_and_files/a.ini"
output_file="$HOME/a.ini"

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
  echo "File $input_file does not exist."
  exit 1
fi

# Get the current working directory (pwd)
current_dir=$(pwd)

# Use sed to replace the specific line and redirect the output to the new file
sed "s|auth_file = /users/gzaniolo/userlist.txt|auth_file = $current_dir/userlist.txt|" "$input_file" > "$output_file"


cp $HOME/emulab_scripts_and_files/userlist.txt $HOME/userlist.txt
