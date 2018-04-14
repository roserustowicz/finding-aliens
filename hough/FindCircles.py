import numpy as np
import matplotlib.pyplot as plt
import scipy
from scipy import misc 
import os
import json
import cv2

def FindTheCircles(imgIn,plotYes):

    # blur the input image
    imgIn = cv2.GaussianBlur(imgIn,(5,5),0)
    # find circles
    circles = cv2.HoughCircles(imgIn,cv2.HOUGH_GRADIENT,1,20,param1=200,param2=15,minRadius=10,maxRadius=25)

    circles = np.uint16(np.around(circles))
    for i in circles[0,:]:
        # draw the outer circle
        cv2.circle(imgIn,(i[0],i[1]),i[2],(0,255,0),2)
        # draw the center of the circle
        cv2.circle(imgIn,(i[0],i[1]),2,(0,0,255),3)
    if plotYes==1 :
        plt.figure()
        plt.imshow(imgIn)
        plt.show()

    return circles

#img = cv2.imread('landsat_kansas_2016_2017.png')
img = cv2.imread('Iran/landsat_iran_2016_2017_f.png')
img = img[:,:,1]

circles=FindTheCircles(img,0)
print('number of circles is: ' +str(len(circles[0])))