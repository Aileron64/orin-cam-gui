# QT Quick Controls 2

wget http://master.qt.io/archive/qt/5.15/5.15.2/submodules/qtquickcontrols2-everywhere-src-5.15.2.tar.xz
tar -xpf qtquickcontrols2-everywhere-src-5.15.2.tar.xz

cd qtquickcontrols2-everywhere-src-5.15.2
/usr/local/Qt-5.15.2/bin/qmake 
make -j4
sudo make install
