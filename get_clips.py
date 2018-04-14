import cv2
import numpy as np
 
if __name__ == '__main__' :
 
    # Read image
    im = cv2.imread("../landsat_kansas_2016_2017.png")
    imCrop = []

    # Select ROI
    count = 0
    name = raw_input("Enter to continue, 'stop' to stop.")
    while name == '':
        r = cv2.selectROI(im)
        name = raw_input("Enter to continue, 'stop' to stop.")
    
        # Crop image
        cur_selection = im[int(r[1]):int(r[1]+r[3]), int(r[0]):int(r[0]+r[2])]
        cur_selection = cv2.resize(cur_selection, (, 50)) 
        imCrop.append(
        #imCrop = (im[int(r[1]):int(r[1]+r[3]), int(r[0]):int(r[0]+r[2])])
        count += 1

    print(len(imCrop))
    # Display cropped image
    arr = np.concatenate(imCrop)
    print(arr.shape)
    cv2.imshow("Image", imCrop)
    cv2.waitKey(0)
