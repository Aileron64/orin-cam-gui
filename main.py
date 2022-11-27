import sys

from PySide2.QtWidgets import QApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtQuickControls2 import QQuickStyle

from app import App

if __name__ == '__main__':
    main = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    QQuickStyle.setStyle("Material")
    ctx = engine.rootContext()
    engine.load('MainWindow.qml')
    win = engine.rootObjects()[0]

    app = App()
    ctx.setContextProperty("app", app)
    
    win.showFullScreen()
    sys.exit(main.exec_())
