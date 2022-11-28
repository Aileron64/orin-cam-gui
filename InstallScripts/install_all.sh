
sh install_dependencies.sh

sh install_qtbase.sh
cd ..

sh install_qml.sh
cd ..

sh install_qtquickcontrolrs.sh
cd ..

sh install_multimedia.sh
cd ..

sudo apt-get install python3-setuptools
sudo apt-get install python3-dev

sh install_pyside2.sh