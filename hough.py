import cv2
import numpy as np
from matplotlib import pyplot as plt
from scipy import misc 

img = cv2.imread('landsat_kansas_2016_2017.png')
img = cv2.imread('landsat_iran_2016_2017_f.png')
img = img[:,:,1]
img = cv2.medianBlur(img,5)
#img = cv2.Canny(img,100,200)
#kernel = np.ones((5,5),np.uint8)
#img = cv2.dilate(img,kernel,iterations = 1)

circles = cv2.HoughCircles(img,cv2.HOUGH_GRADIENT,1,20,
                            param1=50,param2=30,minRadius=10,maxRadius=50)
#circles = cv2.HoughCircles(img,cv2.HOUGH_GRADIENT,1,20,
#                            param1=50,param2=30,minRadius=0,maxRadius=0)

circles = np.uint16(np.around(circles))
print(circles.shape)
for i in circles[0,:]:
    # draw the outer circle
    cv2.circle(img,(i[0],i[1]),i[2],(0,255,0),2)
    # draw the center of the circle
    cv2.circle(img,(i[0],i[1]),2,(0,0,255),3)

plt.imshow(img)
plt.show()
#cv2.imshow('detected circles',img)
