#!/usr/bin/env python

'''
Pjer 2015  10

Lucas-Kanade tracker
====================

Lucas-Kanade sparse optical flow demo. Uses goodFeaturesToTrack
for track initialization and back-tracking for match verification
between frames.
'''

import numpy as np

import random

import cv2
import time
import sys
#from common import anorm2, draw_str
from time import clock

out = cv2.VideoWriter('erose.avi',-1,10.0,(512,512))


lk_params = dict( winSize  = (30, 30),
                  maxLevel = 2,
                  criteria = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 15))

feature_params = dict( maxCorners = 500,
                       qualityLevel = 0.1,
                       minDistance = 20,
                       blockSize = 7 )

filen = open('save.txt','w')

class App:
    def __init__(self, video_src):
        self.track_len = 200
        self.detect_interval = 5
        self.tracks = []
        self.cam = cv2.VideoCapture(video_src)
        self.frame_idx = 0
        ret =True

    def run(self):
    	ret =True
    	i=0
        while True and ret:
            ret, frame = self.cam.read()
            if ret:
	            frame_gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
	            triangle = np.array([ [252,253],[256,256], [67,435], [35,410] ], np.int32)
	            cv2.fillPoly(frame_gray,pts = [triangle],color=(60,60,60))
	            cv2.equalizeHist(frame_gray)
	            closed = cv2.erode(frame_gray, None, iterations = 2)
	            out.write(closed)
	            closed = cv2.dilate(closed, None, iterations = 1)
	            closed = cv2.blur(closed,(3,3))
	            closed = cv2.Canny(closed,20,70)
	            i=i+1
	            frame_gray =closed;
	            #cv2.imshow('king',closed);
	            vis = frame.copy()
	
	            time.sleep(0.018)
	
	            if len(self.tracks) > 0:
	                img0, img1 = self.prev_gray, frame_gray
	                p0 = np.float32([tr[-1] for tr in self.tracks]).reshape(-1, 1, 2)
	                p1, st, err = cv2.calcOpticalFlowPyrLK(img0, img1, p0, None, **lk_params)
	                p0r, st, err = cv2.calcOpticalFlowPyrLK(img1, img0, p1, None, **lk_params)
	                d = abs(p0-p0r).reshape(-1, 2).max(-1)
	                good = d < 1
	                new_tracks = []
	                for tr, (x, y), good_flag in zip(self.tracks, p1.reshape(-1, 2), good):
	                    if not good_flag:
	                        continue
	                    tr.append((x, y))
	                    if len(tr) > self.track_len:
	                        del tr[0]
	                    new_tracks.append(tr)
	                    cv2.circle(vis, (x, y), 2, (0, 255, 0), -1)
	                self.tracks = new_tracks

	                print >>filen,'--------------------------------------------------------------------------------------------------'
	                print >>filen,'in the frame'
	                print >>filen,i
	                print >>filen,' '
	                print >>filen,new_tracks
	                print >>filen,''

	                cv2.polylines(vis, [np.int32(tr) for tr in self.tracks], False, (1,0, 5))
	               # draw_str(vis, (20, 20), 'track count: %d' % len(self.tracks))
	
	            if self.frame_idx % self.detect_interval == 0:
	                mask = np.zeros_like(frame_gray)
	                mask[:] = 255
	                for x, y in [np.int32(tr[-1]) for tr in self.tracks]:
	                    cv2.circle(mask, (x, y), 5, 0, -1)
	                p = cv2.goodFeaturesToTrack(frame_gray, mask = mask, **feature_params)
	                if p is not None:
	                    for x, y in np.float32(p).reshape(-1, 2):
	                        self.tracks.append([(x, y)])
	
	
	            self.frame_idx += 1
	            self.prev_gray = frame_gray
	            cv2.imshow('lk_track', vis)
	            
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
