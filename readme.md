# Cozy Cloud Vagrant image for developpments on Windows

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

  -
