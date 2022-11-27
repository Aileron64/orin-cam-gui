# QTBase

wget http://master.qt.io/archive/qt/5.15/5.15.2/submodules/qtbase-everywhere-src-5.15.2.tar.xz 
tar -xpf qtbase-everywhere-src-5.15.2.tar.xz
cd qtbase-everywhere-src-5.15.2/ 

./configure -xcb

make -j4
sudo make install
