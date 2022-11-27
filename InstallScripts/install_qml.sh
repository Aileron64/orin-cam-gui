# QML

wget http://master.qt.io/archive/qt/5.15/5.15.2/submodules/qtdeclarative-everywhere-src-5.15.2.tar.xz
tar -xpf qtdeclarative-everywhere-src-5.15.2.tar.xz

cd qtdeclarative-everywhere-src-5.15.2
/usr/local/Qt-5.15.2/bin/qmake 
make -j4
sudo make install
