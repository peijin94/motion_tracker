# -*- coding: utf-8 -*-
"""
Created on Fri Oct 09 02:33:54 2015

@author: Pjer1
"""

import numpy as np
import cv2

class eros:
    def __init__(self, video_src):
        self.track_len = 200
        self.detect_interval = 5
        self.tracks = []
        self.cam = cv2.VideoCapture(video_src)
        self.frame_idx = 0

    def run(self):
        while True:
            ret, frame = self.cam.read()

    		cv2.imshow('erosion',frame)
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