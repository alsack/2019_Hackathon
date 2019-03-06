#Prevent installs from trying to pull stdin
export DEBIAN_FRONTEND=noninteractive

#update
apt-get update

#install git
apt-get install git

#install desktop and vnc server
apt-get install -y xfce4 virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
apt-get install -y xfce4-goodies tightvncserver
#make it so anyone can launch the gui
sudo sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config
echo "alias desktop='sudo startxfce4 &'" >> /home/vagrant/.bashrc
usermod -G tty vagrant
#set up the vnc server
mkdir /home/vagrant/.vnc
cp /vagrant/vsetup/xstartup /home/vagrant/.vnc/xstartup
echo 'lockheed' | vncpasswd -f > /home/vagrant/.vnc/passwd
chown -R vagrant:vagrant /home/vagrant/.vnc
chmod 0600 /home/vagrant/.vnc/passwd

#install ros and dev packages
sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
apt-get update
apt-get install -y ros-kinetic-desktop-full 
apt-get install -y python-catkin-tools 
apt-get install -y ros-kinetic-robot-localization 
apt-get install -y ros-kinetic-navigation 
apt-get install -y ros-kinetic-usb-cam 
apt-get install -y ros-kinetic-mavros 
apt-get install -y ros-kinetic-mavros-extras 
apt-get install -y ros-kinetic-hector-gazebo-plugins 
apt-get install -y ros-kinetic-geodesy 
apt-get install -y libopencv*

#add ros sources
echo "source /opt/ros/kinetic/setup.bash" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

#install and build PX4
apt-get install -y python-numpy python-toml python-jinja2 
apt-get install -y libprotobuf-dev libprotobuf-c-dev libprotobuf-java 
apt-get install -y protobuf-compiler protobuf-c-compiler

mkdir -p /home/vagrant/ai_battle_drone/px4
cd /home/vagrant/ai_battle_drone/px4
git clone https://github.com/PX4/Firmware.git
cd Firmware
git checkout v1.8.2
git submodule update --init --recursive
make posix_sitl_default
make posix_sitl_default sitl_gazebo

apt-get install geographiclib-tools 
/opt/ros/kinetic/lib/mavros/install_geographiclib_datasets.sh
chmod -R 777 /usr/share/GeographicLib/
echo "export GEOGRAPHICLIB_DATA=\"/user/share/GeographicLib\"" >> /home/vagrant/ai_battle_drone/setup_ai_drone.sh

chown -R vagrant:vagrant /home/vagrant/