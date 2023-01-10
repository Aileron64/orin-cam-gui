import sys
import os 
import json

from PySide2.QtCore import QObject, Slot, Signal
from seedcounter import SeedCounter

class App(QObject):
    def __init__(self, parent=None):
        super(App, self).__init__(parent)

    # API Functions
    #signalExample = Signal(str)

    @Slot(str)
    def setMode(self, example):
        print(example)
        #self.signalExample.emit(example)

    @Slot(str, str)
    def runSeedCounter(self, input, output)
        counter = SeedCounter()
        counter.process_folder(folder_in = input, folder_out = output)

# if __name__ == "__main__":
#     counter = SeedCounter()
#     counter.process_folder(folder_in = "testImages",folder_out = "seedcounter_imgs")
