###### Run
```
Python3 main.py
```

# Orin Setup

###### Dependencies
```
sudo apt-get \
build-dep \
qt5-default 

sudo apt-get install \
build-essential \
git \
cmake \
qt5-default \
libxml2 \
libxslt1.1 \
python-dev \
qtbase5-dev \
libxcb-xinerama0-dev 

sudo apt-get install \
qttools5-dev-tools \
libqt5concurrent5 \
libqt5core5a \
libqt5dbus5 \
libqt5designer5 \
libqt5designercomponents5 \
libqt5gui5 \
libqt5help5 \
libqt5multimedia5 \
libqt5network5 \
libqt5opengl5 \
libqt5opengl5-dev \
libqt5organizer5 \
libqt5positioning5 \
libqt5printsupport5 \
libqt5qml5 \
libqt5quick5 \
libqt5quickwidgets5 \
libqt5script5 \
libqt5scripttools5 \
libqt5sql5 \
libqt5sql5-sqlite \
libqt5svg5 \
libqt5test5 \
libqt5webkit5 \
libqt5widgets5 \
libqt5xml5 \
libqt5xmlpatterns5 \
libqt5xmlpatterns5-dev 

sudo apt-get install \
'^libxcb.*-dev' \
libx11-xcb-dev \
libglu1-mesa-dev \
libxrender-dev \
libxi-dev \
libxkbcommon-dev \
libxkbcommon-x11-dev 

sudo apt-get install \
flex \
bison \
gperf \
libicu-dev \
libxslt-dev \
ruby 

sudo apt-get install \
libxcursor-dev \
libxcomposite-dev \
libxdamage-dev \
libxrandr-dev \
libxtst-dev \
libxss-dev \
libdbus-1-dev \
libevent-dev \
libfontconfig1-dev \
libcap-dev \
libpulse-dev \
libudev-dev \
libpci-dev \
libnss3-dev \
libasound2-dev \
libegl1-mesa-dev \
gperf \
bison \
nodejs 

sudo apt-get install \
libasound2-dev \
libgstreamer1.0-dev \
libgstreamer-plugins-base1.0-dev 
```

###### QTBase
```
wget http://master.qt.io/archive/qt/5.15/5.15.2/submodules/qtbase-everywhere-src-5.15.2.tar.xz 
tar -xpf qtbase-everywhere-src-5.15.2.tar.xz
cd qtbase-everywhere-src-5.15.2/ 

./configure -xcb

make -j4
sudo make install
```

###### QML
```
wget http://master.qt.io/archive/qt/5.15/5.15.2/submodules/qtdeclarative-everywhere-src-5.15.2.tar.xz
tar -xpf qtdeclarative-everywhere-src-5.15.2.tar.xz

cd qtdeclarative-everywhere-src-5.15.2
/usr/local/Qt-5.15.2/bin/qmake 
make -j4
sudo make install
```

###### QT Quick Controls 2
```
wget http://master.qt.io/archive/qt/5.15/5.15.2/submodules/qtquickcontrols2-everywhere-src-5.15.2.tar.xz
tar -xpf qtquickcontrols2-everywhere-src-5.15.2.tar.xz

cd qtquickcontrols2-everywhere-src-5.15.2
/usr/local/Qt-5.15.2/bin/qmake 
make -j4
sudo make install
```

###### Multimedia
```
wget http://master.qt.io/archive/qt/5.15/5.15.2/submodules/qtmultimedia-everywhere-src-5.15.2.tar.xz
tar -xpf qtmultimedia-everywhere-src-5.15.2.tar.xz

cd qtmultimedia-everywhere-src-5.15.2
/usr/local/Qt-5.15.2/bin/qmake 
make -j4
sudo make install
```

###### PySide2
```
sudo apt-get install \
binfmt-support \
libclang-10-dev \
libclang-common-10-dev \
libclang-cpp10 libclang1-10 \
libffi-dev \
libobjc-7-dev \
libobjc4 \
libpfm4 \
libtinfo-dev \
libz3-4 \
libz3-dev \
llvm-10 \
llvm-10-dev \
llvm-10-runtime \
llvm-10-tools

cd ~ 
git clone http://code.qt.io/pyside/pyside-setup.git
cd pyside-setup 
git checkout 5.15.2 
sudo python3 setup.py install --qmake=/usr/local/Qt-5.15.2/bin/qmake
```
