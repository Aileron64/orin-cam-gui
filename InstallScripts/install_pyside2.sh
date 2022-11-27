# PySide2

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