import sys
import os 
import json
import subprocess
import time

#from Seedcounter.seedcounter import SeedCounter
from PySide2.QtCore import QObject, Slot, Signal

class App(QObject):
    def __init__(self, parent=None):
        super(App, self).__init__(parent)

    @Slot(str)
    def setMode(self, example):
        print(example)
        #self.signalExample.emit(example)

    @Slot(str)
    def createDirectories(self, dir):
        os.mkdir(dir)
        os.mkdir(dir + "/input/")
        os.mkdir(dir + "/output/")

    @Slot(str, str)
    def runSeedCounter(self, input, output):
        print(input)
        print(output)
        p = subprocess.run(["python3", "seedcounter.py", input, output])
