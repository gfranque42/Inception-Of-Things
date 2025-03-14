sudo apt update
PACKAGE_NAME="gnome-core"
VIRTUALBOX="virtualbox"
if ! apt list --installed | grep -q "^$PACKAGE_NAME/"; then
    sudo apt install -y gnome-core
    sudo reboot
fi
if ! apt list --installed | grep -q "^$VIRTUALBOX/"; then
    sudo apt update && sudo apt install -y virtualbox
    wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install -y vagrant
    sudo reboot
fi