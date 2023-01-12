import sys
import os 
import json
import subprocess

#from Seedcounter.seedcounter import SeedCounter
from PySide2.QtCore import QObject, Slot, Signal

class App(QObject):
    def __init__(self, parent=None):
        super(App, self).__init__(parent)

    @Slot(str)
    def setMode(self, example):
        print(example)
        #self.signalExample.emit(example)

    @Slot(str, str)
    def runSeedCounter(self, input, output):
        print(input)
        print(output)

        p = subprocess.run(["python3", "seedcounter.py"])
