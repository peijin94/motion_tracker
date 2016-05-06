# -*- coding: utf-8 -*-
"""
Created on Fri Oct 09 02:33:54 2015

@author: Pjer1
"""

import numpy as np
import cv2
import time

out = cv2.VideoWriter('erose.avi',-1,10.0,(512,512))

class eros:
    def __init__(self, video_src):
        self.track_len = 200
        self.detect_interval = 5
        self.tracks = []
        self.cam = cv2.VideoCapture(video_src)
        self.frame_idx = 0


    def run(self):
        ret =True
        while True and ret:
            ret, frame = self.cam.read()
            time.sleep(0.015)

            closed = cv2.erode(frame, None, iterations = 2)
            #closed = cv2.dilate(closed, None, iterations = 1)
            closed = cv2.dilate(closed, None, iterations = 1)
            closed = cv2.blur(closed,(3,3))
            cv2.imshow('test',closed)
            out.write(closed)
            ch = 0xFF & cv2.waitKey(1)
            if ch == 27:
                break


def main():
    import sys
    try: video_src = sys.argv[1]
    except: video_src = 0

    print __doc__
    eros(video_src).run()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    main()