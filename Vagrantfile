# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

# Message displayed after boot of the vm
$msg =<<MSG
-------------------------------------------------------------------
                                                 %@

 ,#@#W@@p   e@8W@@M,   @@@@@@@@b'@@      #@      @b    ;@#WW@M,
6@C       ,@#     7$k       ##`  '@@    {$`      $b   @#     "Sk
$$        @$~      @$     ;@^     '@k  {@^       $b  |$b      @$
@@        !$b      S@   ,@#        ^Sk;$b        $b  |$b      @$
 @@w,,,#k  "$k,,,e@W   M@Q,,,,,     "$@C   &@k   $b   7@k,,,;@#`
   `^^`       ^^^`     ````````     ;$b    `^`   ``      `^^`
                                   ;$b
-------------------------------------------------------------------

The virtual machine with a complete Cozy stack for your dev is up !

___________
Warnings :

* This machine is FOR DEVELOPMENT ONLY
* Data are in the machine, so IF YOU DELETE THE MACHINE
  YOU DELETE THE DATA.
___________
That said :

* Access your Cozy for your tests here :
  http://cozy.tools:8080  (pwd = cozy)

* You can connect to the guest machine throught SSH with
  `vagrant ssh`

* You can acces from your host to a shared directory
  within the guest at this adress :
  \\\\192.168.33.10\\shared
  (past into your windows file explorer)
  (in Windows 10 you must :
    - activate SMB1 clients : `Set-SmbServerConfiguration -EnableSMB1Protocol $true`
    - enable access to "unsecure clients" : https://tech.nicolonsky.ch/windows-10-1709-cannot-access-smb2-share-guest-access/
    - see also : https://support.microsoft.com/en-us/help/2696547/detect-enable-disable-smbv1-smbv2-smbv3-in-windows-and-windows-server

  )

* Inside the vm the shared directory location is :
  /home/vagrant/shared

* Add your developpments files into this directory. You can edit them from the host or from
  the guest.

* To start your Cozy app from a template you can from the guest :
  `cd /home/vagrant/shared`
  `create-cozy-app mycozyapp`
  more info : https://github.com/CPatchane/create-cozy-app

* You can the edit your code from the guest in the shared
  folder !
  ( \\\\192.168.33.10\\shared )

* To deploy your app [to be continued]

sudo systemctl stop cozy-stack.service
sudo systemctl restart cozy-stack.service
sudo systemctl status cozy-stack.service
sudo systemctl start cozy-stack.service
sudo cozy-stack serve --dev --appdir app:/home/vagrant/shared/app-build --allow-root --disable-csp


* /!\\ THE CODE OF THE SHARED FOLDER IS STORED IN THE VIRTUAL MACHINE !
  Don't forget to push your code regularly on your repo /!\\
-----------------------------------------------------------------
MSG

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # uncomment if you want to have a UI. Common use cases include wanting to see
  # a browser that may be running in the machine, or debugging a strange boot
  # issue.
  # config.v  m.provider "virtualbox" do |v|
  #   v.gui = true
  # end

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "debian/stretch64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # for the Cozy Stack
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  # for create-cozy-app
  config.vm.network "forwarded_port", guest: 8888, host: 8888
  # ???
  config.vm.network "forwarded_port", guest: 3333, host: 3333
  # ???
  config.vm.network "forwarded_port", guest: 8181, host: 8181
  config.vm.network "forwarded_port", guest: 9856, host: 9856 # for realtime socket - to be deleted

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "3072"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  config.vm.provision :shell, :path => ".provision/bootstrap.sh"

  # MESSAGE AFTER VAGRANT UP
  config.vm.post_up_message = $msg

end
