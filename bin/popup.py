#!/usr/bin/python

import sys
import random
from PySide6 import QtCore, QtWidgets, QtGui

class MyWidget(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()

        self.text = QtWidgets.QLabel(sys.argv[2],
                                     alignment=QtCore.Qt.AlignLeft)

        self.layout = QtWidgets.QVBoxLayout(self)
        self.layout.addWidget(self.text)

        self.time = 0
        self.timeout = int(sys.argv[1])
        self.timer = QtCore.QTimer(self)
        self.timer.setInterval(100)
        self.timer.timeout.connect(self.timeoutExpired)
        self.timer.start()

    @QtCore.Slot()
    def timeoutExpired(self):
        self.time += self.timer.interval()

        if self.isActiveWindow():
            self.time = 0
            self.timer.start()
        elif self.time >= self.timeout:
            self.close()

    def mousePressEvent(self, event):
        super(MyWidget, self).mouseReleaseEvent(event)
        self.close()

if __name__ == "__main__":
    app = QtWidgets.QApplication([])

    widget = MyWidget()
    size = widget.sizeHint()

    rect = app.primaryScreen().geometry()
    
    offset = 10

    offsetX = offset
    offsetY = offset + 24

    x = rect.right() - size.width() - offsetX
    y = rect.top() + offsetY

    widget.move(x, y)

    widget.show()

    sys.exit(app.exec())
