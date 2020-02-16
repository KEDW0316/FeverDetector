#!/usr/bin/env bash
#File Created by Jerry Pierre and Edited by Karl Parks, Fox Chao
#sudo chmod 775 setup_linux_env.sh
#sudo ./setup_linux_env.sh

install_system_updates(){

    echo "updating system."
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get dist-upgrade -y --autoremove

}

install_thermal_dependencies(){

    echo "Installing thermal dependencies."
    sudo apt install python3-pip -y
    sudo apt-get install -y python3-pyqt5
    sudo apt-get install -y python3-h5py
    sudo apt-get install -y python3-psutil
    sudo apt-get install -y python3-opencv
    #sudo pip3 install opencv-contrib-python
    #git clone https://github.com/Itseez/opencv_contrib.git
    #cd opencv_contrib
    #git checkout 3.1.0
    #cd ..
    sudo pip3 install --no-cache-dir tifffile
    sudo apt-get install -y python3-matplotlib
    sudo apt-get install -y libatlas-base-dev
    sudo apt-get install -y libjasper-dev
    sudo apt-get install -y libqtgui4
    sudo apt-get install -y libqt4-test

}

install_thermal_app(){

    echo "Installing and building thermal app."
    sudo apt install git -y
    #git clone https://github.com/Kheirlb/purethermal1-uvc-capture.git
    git clone https://github.com/groupgets/libuvc
    sudo apt-get install cmake -y
    sudo apt-get install libusb-1.0-0-dev -y
    sudo apt-get install libjpeg-dev -y
    cd libuvc
    mkdir build
    cd build
    cmake ..
    make && sudo make install
    sudo ldconfig -v
    cd ../..

    sudo sh -c "echo 'SUBSYSTEMS==\"usb\", ATTRS{idVendor}==\"1e4e\", ATTRS{idProduct}==\"0100\", SYMLINK+=\"pt1\", GROUP=\"usb\", MODE=\"666\"' > /etc/udev/rules.d/99-pt1.rules"
}

main () {
    install_system_updates
    install_thermal_dependencies
    install_thermal_app
}

main "$@"

