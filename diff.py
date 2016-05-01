import numpy as np 
import cv2
import time

cap = cv2.VideoCapture('s.mpeg')

out = cv2.VideoWriter('diff.avi',-1,10.0,(512,512))

ret,frame1 = cap.read()
while (True and ret):
	ret,frame1 = cap.read()
	ret,frame2 = cap.read()

	gray1 = cv2.cvtColor(frame1,cv2.COLOR_BGR2GRAY)
	gray2 = cv2.cvtColor(frame2,cv2.COLOR_BGR2GRAY)

	gray = cv2.cvtColor(frame2-frame1+20,cv2.COLOR_BGR2GRAY)
	cv2.imshow('frame',gray+40)
	time.sleep(0.2)
	out.write(gray+40)
	if cv2.waitKey(1) & 0xFF == ord('q'):
		break
cap.release()
cv2.destroyAllWindows()