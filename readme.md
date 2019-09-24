# Cozy Cloud Vagrant image for developpments on Windows

# TODO :
Comment démarrer la stack pour qu'elle sache chercher dans un répertoire tous les liens symboliques vers des répertoires où sont les build d'apps
patrick
Bash
cd ~/code/cozy/cozy-env/apps
~/code/cozy/cozy-stack/scripts/cozy-app-dev.sh -d .

le repertoire ou je demarre la stack contient les liens symboliques
Bash
$ ls -lh ~/code/cozy/cozy-env/apps/
total 0
lrwxr-xr-x  1 cozy  staff    33B Aug  7 20:40 banks -> /Users/cozy/code/cozy/banks/build
lrwxr-xr-x  1 cozy  staff    38B Aug 29 09:29 home -> /Users/cozy/code/cozy/cozy-home/build/
lrwxr-xr-x  1 cozy  staff    37B Aug  8 14:22 keys -> /Users/cozy/code/cozy/cozy-keys/build
drwxr-xr-x  4 cozy  staff   128B Aug  7 21:03 storage

# What you can expect
* Setup a Cozy Cloud development environment on Windows thanks to a debian virtual machine
* The VM contains the whole Cozy stack up and running for development NOT FOR PRODUCTION (security is disabled)
* A shared folder between windows and the VM is setup so that you can edit your application code from Windows.

## How to

* Prerequisites :
  - [vagrant](https://www.vagrantup.com/downloads.html) on your windows host machine
  - a decent console emulator ([cmder](http://cmder.net/) for instance)

* Installation
  * download in an empty directory the `Vagrant` file and the folder `.provision` (let's call this directory the *vagrant directory*)
  * in your favorite console go in the directory and run `vagrant up`
  * That's it !

* Usage (note all `vagrant XXX` commands are run in the *vagrant directory* ) :

  - start the VM : `vagrant up`

  - stop the VM : `vagrant halt`

  - Access your Cozy for your tests here :
    http://cozy.tools:8080  (pwd = cozy)

  - the shared directory (SAMBA server) :
    - in host (Windows) : \\192.168.33.10\shared
    - in guest (debian VM) : /home/vagrant/shared
  - to long into the VM : `vagrant ssh` (you will be loged with root privileges)

  * Add your developpments files into this directory. You can edit them from the host or from
    the guest.( \\192.168.33.10\shared or /home/vagrant/shared )

  * To start your Cozy app from a template you can from the guest :
  `cd /home/vagrant/shared`
  `create-cozy-app mycozyapp`
  more info : https://github.com/CPatchane/create-cozy-app

  * You can the edit your code from Windows in the shared
    folder !

  * To deploy your app [to be continued]

  * /!\ The code of the shared folder is stored in the virtual machine :
    don't forget to push your code regularly /!\
