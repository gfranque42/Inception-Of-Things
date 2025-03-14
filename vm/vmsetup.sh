sudo adduser --disabled-password --gecos '' user
echo 'user:2003' | sudo chpasswd
sudo usermod -aG sudo user
sudo echo "deb http://deb.debian.org/debian/ sid main contrib non-free" >> /etc/apt/sources.list
