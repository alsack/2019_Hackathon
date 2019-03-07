# 2019_Hackathon
2019 Battle Drone Hackathon.  The dev environment is build using (Vagrant)[https://www.vagrantup.com/] to install/provision a VM (Virtualbox) with ROS, Gazebo, PX4, etc.

Once vagrant is installed, navigate to this folder and run 'vagrant up' to deploy and provision the VM.  I set it up as a bridged network, so you will need to specify the network adapter for the VM to use.

Once deployed:
* type 'vagrant ssh' to log in to the vagrant box.
* Run 'desktop' in the box to launch an xfce4 desktop.
* After running 'desktop' you can run 'x11server' to launch a vnc server.

Known issues:
* The desktop doesn't launch correctly if you run it as the vagrant user.  Running 'desktop' is the workaround, but opens the desktop as the root user, not as the vagrant user.
