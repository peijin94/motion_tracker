# Motion Tracker
## abstract
this is a project developed long ago and not well completed

contains these modules:
 - preprocessing erode
 - preprocessing differential
 - preprocessing guassian blur
 - LK track with OPENCV

##main module
###preprocessing erode 
necessary imports
```python
import numpy as np
import cv2
import time
```
use cv2.erode module to eliminate little stars in image which will be picked up as concerned point by LK optical flow,but we don't really interested in.

and then processing guassian blur to eliminate high frequency parts in image
code:  
```python
closed = cv2.erode(frame, None, iterations = 2)
closed = cv2.blur(closed,(3,3))
```
this is the first step of processing

###differential module
 to get a better view of the moving parts
```python
gray1 = cv2.cvtColor(frame1,cv2.COLOR_BGR2GRAY)
gray2 = cv2.cvtColor(frame2,cv2.COLOR_BGR2GRAY)
gray = cv2.cvtColor(frame2-frame1+20,cv2.COLOR_BGR2GRAY)
```
using frame minus to get the differential flow and add 20 to avoid underflow of  uint8 

###LK optical-flow
using the opencv optical-flow module to processing the image flow 

 
more about it please visit [My_blog]

[my site]


   [My_blog]:<http://pjer.blog.ustc.edu.cn>
   [my site]:<http://home.ustc.edu.cn/~pjer1316>
