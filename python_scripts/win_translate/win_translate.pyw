import sys
from PyQt5 import QtWidgets, QtGui, QtCore
from PyQt5.QtGui import QKeySequence
from PyQt5.QtCore import Qt
from googletrans import Translator
from win10toast import ToastNotifier
import design


def show_messageBox(msgText, titleText, icon, buttons):
    mBox = QtWidgets.QMessageBox()
    mBox.setIcon(icon)
    mBox.setText(msgText)
    mBox.setWindowTitle(titleText)
    mBox.setStandardButtons(buttons)
    mBox.exec_()


class TranslateApp(QtWidgets.QMainWindow, design.Ui_MainWindow):

    def __init__(self):

        super().__init__()
        self.setupUi(self)
        
        self.translate_shortcut_clear = QtWidgets.QShortcut(QKeySequence('Ctrl+Return'), self)
        self.translate_shortcut_clear.activated.connect(lambda: self.translate_text(True))

        self.translate_shortcut_non_clear = QtWidgets.QShortcut(QKeySequence('Ctrl+Shift+Return'), self)
        self.translate_shortcut_non_clear.activated.connect(lambda: self.translate_text(False))
        
        self.exit_shortcut = QtWidgets.QShortcut(QKeySequence('Esc'), self)
        self.exit_shortcut.activated.connect(QtWidgets.QApplication.instance().quit)

        self.trans = Translator()
        self.toaster = ToastNotifier()

    def translate_text(self, flag):
        text = self.textEdit.toPlainText()

        if text == "":
            show_messageBox("Не введен текст для перевода", "Ошибка", QtWidgets.QMessageBox.Critical, QtWidgets.QMessageBox.Ok)
            return

        if flag:
            self.textEdit.clear()

        self.toaster.show_toast(
        	"Перевод", 
        	self.trans.translate(text, src='en', dest='ru').text,
        	duration=4,
        	threaded=True
        )


def main():
    app = QtWidgets.QApplication(sys.argv)
    window = TranslateApp()
    window.show()
    app.exec_()


if __name__ == "__main__":
    main()
