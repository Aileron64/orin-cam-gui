# Multimedia

wget http://master.qt.io/archive/qt/5.15/5.15.2/submodules/qtmultimedia-everywhere-src-5.15.2.tar.xz
tar -xpf qtmultimedia-everywhere-src-5.15.2.tar.xz

cd qtmultimedia-everywhere-src-5.15.2
/usr/local/Qt-5.15.2/bin/qmake 
make -j4
sudo make install
