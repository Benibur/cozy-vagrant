#!/bin/bash
echo "####################"
echo "Configuring vagrant server"
echo "####################"

id

apt-get install -y curl
# NODEJS
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt-get install -y nodejs

# YARN
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install -y yarn

# BUILD TOOLS
apt-get install -y build-essential

# COZY-CREATE-APP
yarn global add create-cozy-app

# SAMBA :
# . https://help.ubuntu.com/community/How%20to%20Create%20a%20Network%20Share%20Via%20Samba%20Via%20CLI%20(Command-line%20interface/Linux%20Terminal)%20-%20Uncomplicated,%20Simple%20and%20Brief%20Way!
# . https://www.virtualbox.org/manual/ch06.html  (pour la gestion réseau de samba sur virtualbox via une interface réseau "host only")
apt install -y samba
# Create a directory to be shared
mkdir -p /home/vagrant/shared/app-build/
chown vagrant /home/vagrant/shared/
chmod 777 /home/vagrant/shared/
#
cat << EOF >> /etc/samba/smb.conf
[shared]
path = /home/vagrant/shared
public = yes
read only = no
browseable = yes
writable = yes
guest ok = yes
guest only = yes
guest account = vagrant
force group = vagrant
force user = vagrant
create mask = 0777
directory mask = 0777
force create mode = 0777
force directory mode = 0777
min protocol = SMB2
max protocol = SMB2

EOF
service smbd restart

# COZY
curl https://apt.cozy.io/cozy.gpg | apt-key --keyring /etc/apt/trusted.gpg.d/cozy.gpg add -
echo "deb https://apt.cozy.io/debian/ stretch testing" > /etc/apt/sources.list.d/cozy.list
apt-get update

debconf-set-selections <<EOF
cozy-couchdb couchdb/mode select standalone
cozy-couchdb couchdb/bindaddress string 0.0.0.0
cozy-couchdb couchdb/nodename string couchdb@127.0.0.1
cozy-couchdb couchdb/adminpass password admin
cozy-couchdb couchdb/adminpass_again password admin

cozy-stack cozy-stack/couchdb/nodename string couchdb@127.0.0.1
cozy-stack cozy-stack/couchdb/address string 127.0.0.1:5984

cozy-stack cozy-stack/couchdb/admin/user string admin
cozy-stack cozy-stack/couchdb/admin/password password admin
cozy-stack cozy-stack/couchdb/admin/password_again password admin

cozy-stack cozy-stack/couchdb/cozy/user string cozy
cozy-stack cozy-stack/couchdb/cozy/password password cozy
cozy-stack cozy-stack/couchdb/cozy/password_again password cozy

cozy-stack cozy-stack/cozy/password password admin
cozy-stack cozy-stack/cozy/password_again password admin

cozy-stack cozy-stack/address string 0.0.0.0
cozy-stack cozy-stack/port string 8080
cozy-stack cozy-stack/admin/address string 127.0.0.1
cozy-stack cozy-stack/admin/port string 6060
EOF


cat > /etc/systemd/system/cozy-stack.service <<EOF
[Unit]
Description=Cozy service
Wants=couchdb.service
After=network.target couchdb.service

[Service]
User=cozy-stack
Group=cozy
PermissionsStartOnly=true
ExecStart=/usr/bin/cozy-stack serve --dev --appdir app:/home/vagrant/shared/app-build
Restart=always

[Install]
WantedBy=multi-user.target
EOF

apt install -y --no-install-recommends cozy-couchdb cozy-stack cozy-nsjail debootstrap lsb-release

# CREATION OF A COZY INSTANCE
# url from the host machine = http://cozy.tools:8080
# password                  = cozy
export COZY_ADMIN_PASSWORD=admin
cozy-stack config passwd /etc/cozy
cozy-stack instances add --apps home,onboarding,settings,drive,photos,collect --passphrase cozy cozy.tools:8080

# MODIFY THE DEFAULT FOLDER WHEN LOGIN
echo ' ' >> /home/vagrant/.bashrc
echo '# DEFAULT FOLDER WHEN LOGIN' >> /home/vagrant/.bashrc
echo 'cd ~/shared/' >> /home/vagrant/.bashrc
echo 'export HOST=0.0.0.0' >> /home/vagrant/.bashrc
