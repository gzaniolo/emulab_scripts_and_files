

# NOTE: 
# Setting up tigger is a massive pain in the ass. I have not bothered to make
#  this file perfectly set up tigger because it turns out this will not actually
#  produce a functional tigger. As such, the method installation is likely to 
#  change.

# This also means:
# DO NOT RUN THIS SCRIPT IT WILL NOT WORK
# Use it as a set of instructions to get to the point where I got.
# With these instructions you should be able to make a tigger for which.
# 1. The ebpf code compiles and "runs" (no errors/warnings)
# 2. pgbouncer compiles, starts up and "runs" (no errors or warnings) with the
#  changes added by the tigger repository.

# Additional warning: Following these instructions directly will probably 
#  destroy whatever work you had in an existing ~/pgbouncer directory



# packages necessary for bpftool I believe
sudo apt update
sudo apt install libbfd-dev
sudo apt install llvm
sudo apt install clang
sudo apt install libcap-dev
sudo apt install libelf-dev
sudo apt-get install linux-headers-$(uname -r)
sudo apt install libbpf-dev


cd $HOME
# https://github.com/libbpf/bpftool/tree/main
# bpftool seems to be mostly backwards compatible. However, here is a link to a
#  version that I think was released roughly at the same time as tigger if you
#  find that useful: 
# https://github.com/libbpf/bpftool/tree/b01941c8f7890489f09713348a7d89567538504b
git clone --recurse-submodules https://github.com/libbpf/bpftool.git
cd bpftool
git submodule init
git submodule update
cd src
make
make install

# HERE ARE THINGS YOU MUST DO MANUALLY!!!!!
# === Start ===
sudo nano /etc/security/limits.conf
# append:
*    soft    memlock    unlimited
*    hard    memlock    unlimited

sudo nano /etc/pam.d/common-session
# append:
session required pam_limits.so


# log out and log back into the shell

# === End ===



# Packages necessary for pgbouncer I believe
sudo apt install libtool
sudo apt install libevent-dev
sudo apt install pkg-config
sudo apt install libssl-dev
sudo apt install pandoc


cd $HOME
# https://github.com/mbutrovich/tigger
git clone https://github.com/mbutrovich/tigger.git

# https://github.com/pgbouncer/pgbouncer
git clone https://github.com/pgbouncer/pgbouncer.git

cp -r pgbouncer pgbouncer-2
cd pgbouncer-2
# This is the commit that tigger forked from
# https://github.com/pgbouncer/pgbouncer/commit/9a346b0e451d842d7202abc3eccf0ff5a66b2dd6
git checkout -b v17 9a346b0e451d842d7202abc3ec
cd ..
cp -r tigger/* pgbouncer-2


cd pgbouncer-2
rm -rf lib
git submodule init
git submodule update

./autogen.sh
./configure


# HERE ARE THINGS YOU MUST DO MANUALLY!!!!!
# === Start ===

# This part is really weird:

# Firstly, you must go into the makefile, find the line:
# LIBS := 
# and change it to:
# LIBS := -L/usr/lib -lbpf

# Additionally, for the ebpf portion to run, you must go search for all 
#  uncommented instances of 'bpf_printk(...)' in the pgbouncer code, and comment
#  them out.

# === End ===


make
sudo make install

cd bpf
make


# Copy some modify and copy some configuration files. This probably won't work
#  if not run in emulab

# a.ini must be modified to contain your home directory if you want to run it 
#  the way I describe. It probably would have been easier if I just copied 
#  the userlist file into /etc/<something...> or wherever it was supposed to go.
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



# HERE ARE THINGS YOU MUST DO MANUALLY!!!!!
# === Start ===

# In the end, you must have the bpf component running with 
cd $HOME/pgbouncer-2/bpf
sudo ./mp_bouncer

# and the non bpf component running with 
cd $HOME
pgbouncer a.ini

# === End ===


