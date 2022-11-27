import sys
import os 
import json

from PySide2.QtCore import QObject, Slot, Signal

class App(QObject):
    def __init__(self, parent=None):
        super(App, self).__init__(parent)

    # API Functions
    #signalExample = Signal(str)

    @Slot(str)
    def setMode(self, example):
        print(example)
        #self.signalExample.emit(example)