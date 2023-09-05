#!/bin/python

import os
import sys
from PyQt5 import QtWidgets, QtGui, QtCore
from PyQt5.QtGui import QKeySequence
from PyQt5.QtCore import Qt
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

        self.change_language_shortcut = QtWidgets.QShortcut(QKeySequence('Alt+Return'), self)
        self.change_language_shortcut.activated.connect(self.change_language)
        
        self.translate_shortcut_clear = QtWidgets.QShortcut(QKeySequence('Ctrl+Return'), self)
        self.translate_shortcut_clear.activated.connect(lambda: self.translate_text(True))

        self.translate_shortcut_non_clear = QtWidgets.QShortcut(QKeySequence('Ctrl+Shift+Return'), self)
        self.translate_shortcut_non_clear.activated.connect(lambda: self.translate_text(False))
        
        self.exit_shortcut = QtWidgets.QShortcut(QKeySequence('Esc'), self)
        self.exit_shortcut.activated.connect(QtWidgets.QApplication.instance().quit)

    def change_language(self):
        if self.comboBox.currentIndex():
            self.comboBox.setCurrentIndex(0)
        else:
            self.comboBox.setCurrentIndex(1)


    def translate_text(self, flag):
        text = self.textEdit.toPlainText()

        if text == "":
            show_messageBox("Не введен текст для перевода", "Ошибка", QtWidgets.QMessageBox.Critical, QtWidgets.QMessageBox.Ok)
            return

        if flag:
            self.textEdit.clear()

        lang = ":ru"
        if self.comboBox.currentIndex():
            lang = ":en"
        
        os.system(f'trans-notify "{text}" {lang}')


def main():
    app = QtWidgets.QApplication(sys.argv)
    window = TranslateApp()
    window.show()
    app.exec_()


if __name__ == "__main__":
    main()
