# -*- coding: utf-8 -*-
"""
Created on Thu Oct 08 00:46:38 2015


a simple gui

@author: Pjer1
"""

import sys
from PyQt4 import QtGui,QtCore
from PyQt4.QtGui import *
import cv2



app = QtGui.QApplication(sys.argv)

class cme_window(QtGui.QWidget):

    filename = ''    
    
    def __init__(self):
        super(cme_window, self).__init__()
        
        self.initUI()
        
        
    def initUI(self):
        
    	#everything needed to get the window ready

        self.setGeometry(300, 100, 1000, 700)
        self.setFixedSize(1000,700)
        self.setWindowTitle('Icon')
        self.setWindowIcon(QtGui.QIcon('pjer.ico'))        
        self.btnQuit = QtGui.QPushButton('Quit',self)
        self.btnQuit.resize(60,25)
        self.image = QtGui.QImage()    
        
        self.status = 0 #0 is init status;1 is play video; 2 is capture video
        #self.btnQuit.setFlat(True)
        
        #self.videowriter =  cv2.cv.CreateVideoWriter("test.mpg", cv2.CV_FOURCC('m','p','g','1'), 25, cv2.cvSize(200,200), 1)
        self.playcapture =  cv2.cv.CreateFileCapture("test.avi")
        #this is the control sequense
        #self.setStyleSheet('QPushButton {background:black}')
        
        exitcme = QtGui.QAction( QtGui.QIcon('images/app_icon.png'), 'Exit', self )
        #exit.setShortcut('Ctrl+Q')  //a shout cut
        exitcme.setStatusTip('Exit application')
        self.connect(exitcme, QtCore.SIGNAL('triggered()'), QtCore.SLOT('close()'))

        openfile = QtGui.QAction('Open video file',self)
        self.connect(openfile,QtCore.SIGNAL('triggered()'), self.openf)        
        
        savefile = QtGui.QAction('Save to',self)        
        self.connect(savefile,QtCore.SIGNAL('triggered()'), self.savef)        
        
        helpme = QtGui.QAction('Help',self)
        
        aboutme =QtGui.QAction('About',self)       

        graylevel = QAction('gray',self)
        
        QtCore.QObject.connect(self.btnQuit, QtCore.SIGNAL("clicked()"),
        							app, QtCore.SLOT("quit()"))
        
        self.capturebtn = QtGui.QPushButton('capture')
        
        self.piclabel = QLabel('pic',self);
        self.piclabel.resize(300,300)
        self.piclabel.move(20,60)
       
        if self.image.load("test.png"):
           self.piclabel.setPixmap(QPixmap.fromImage(self.image))  
       
       
       
        menubar = QtGui.QMenuBar(self)
        FileMenu = menubar.addMenu('File')
        FileMenu.addAction(openfile)
        FileMenu.addAction(savefile) 
        FileMenu.addAction(exitcme)
 
        ToolMenu = menubar.addMenu('view')
        ToolMenu.addAction(graylevel)

        HelpMenu = menubar.addMenu('Help')
        HelpMenu.addAction(helpme)
        HelpMenu.addAction(aboutme)
            
        self.btnQuit.move(900,650)
        self.show()
        
    def openf(self):

        # Get filename and show only .writer files
        self.filename = QtGui.QFileDialog.getOpenFileName(self, 'Open File',".")

        if self.filename:
            with open(self.filename,"rt") as file:
                self.text.setText(file.read())

    def savef(self):

        # Only open dialog if there is no filename yet
        if not self.filename:
            self.filename = QtGui.QFileDialog.getSaveFileName(self, 'Save File')

        # Append extension if not there yet
        if not self.filename.endswith(".writer"):
            self.filename += ".writer"

        # We just store the contents of the text file along with the
        # format in html, which Qt does in a very nice way for us
        with open(self.filename,"wt") as file:
            file.write(self.text.toHtml())    
def main():
    ex = cme_window()
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()  
