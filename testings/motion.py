import numpy as np
import cv2
import time
#from common import anorm2, draw_str
from time import clock


class App:
    def __init__(self, video_src):
        self.track_len = 10
        self.detect_interval = 5
        self.tracks = []
        self.cam = cv2.VideoCapture(video_src)
        self.frame_idx = 0
    def run(self):
        ret1,frame1 = self.cam.read()
        gframe1 = cv2.cvtColor(frame1,cv2.COLOR_BGR2GRAY)
        ret2,frame2 = self.cam.read()
        gframe2 = cv2.cvtColor(frame2,cv2.COLOR_BGR2GRAY)
        ret3,frame3 = self.cam.read()
        gframe3 = cv2.cvtColor(frame3,cv2.COLOR_BGR2GRAY)
        ret4,frame4 = self.cam.read()
        gframe4 = cv2.cvtColor(frame4,cv2.COLOR_BGR2GRAY)
        while True:
            ret1, frame = self.cam.read()
            gframe = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)

            gframe1 = gframe2
            gframe2 = gframe3
            gframe3 = gframe4
            gframe4 = gframe            

            #bl = cv2.blur(gframe3,(9,9))
            edged=cv2.Canny(gframe3,40,80)

            closed = cv2.erode(gframe, None, iterations = 2)
            closed = cv2.dilate(closed, None, iterations = 1)
            cv2.imshow('king',closed)#-gframe2/2-gframe1/2+10)
            time.sleep(0.2)
            ch = 0xFF & cv2.waitKey(1)
            if ch == 27:
                break

def main():
    import sys
    try: video_src = sys.argv[1]
    except: video_src = 0

    print __doc__
    App(video_src).run()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    main()
