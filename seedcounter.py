import os
#os.environ['CUDA_VISIBLE_DEVICES'] = '-1'
#os.environ['CUDA_VISIBLE_DEVICES'] = '1'
#os.environ['CUDA_VISIBLE_DEVICES'] = '0'

import cv2
import keras
import numpy as np
import matplotlib.pyplot as plt
import time
from icecream import ic
import segmentation_models as sm
import glob



class SeedCounter:
    _FNAME_TRAY          = "cp_best_mobilenet_from_finetuned.h5"
    _BACKBONE_TRAY       = 'mobilenet'
    _N_CLASSES_TRAY      = 1
    _HGHT_TRAY           = 512
    _WDTH_TRAY           = 512
    _IN_RANGE_START      = (180,180,180)
    _IN_RANGE_END        = (255,255,255)
    _CONNECTIVITY        = 4 
    _DEBUG               = True
    _AREA_MIN            = 40
    _AREA_MAX            = 23000
    _AREA_MIN_TRAY       = 30000
    _AREA_MAX_TRAY       = 16588800
    
    
    
    def __init__(self):
        self.init_tray_model()
       
    
    
    
    
    def save_image(self,fname,image):
        cv2.imwrite(fname,image)


    def get_mask_from_image(self,image):
        
        HGHT_L = np.shape(image)[0]
        WDTH_L = np.shape(image)[1]
        image_copy = image.copy()
        image_small = cv2.resize(image, (self.height,self.width), interpolation = cv2.INTER_AREA) 
        image_small = cv2.cvtColor(image_small, cv2.COLOR_BGR2RGB)
        image_small = np.expand_dims(image_small, axis=0)
        pr_mask = self.model.predict(image_small).round()
        pr_mask=pr_mask[..., 0].squeeze()
        pr_mask_big_gray = cv2.resize(pr_mask, (WDTH_L,HGHT_L), interpolation = cv2.INTER_AREA) 
        pr_mask_big_color =  cv2.cvtColor(pr_mask_big_gray,cv2.COLOR_GRAY2BGR)
        pr_mask_big_color[pr_mask_big_gray>0] = (0,0,255)
        pr_mask_big_color = np.asarray(pr_mask_big_color, np.uint8)
        return pr_mask_big_gray,pr_mask_big_color
        
        
        
        

    def process_count_via_connectedComponents(self,image):
        
        output = image.copy()
        gray_original = cv2.cvtColor(image,cv2.COLOR_BGR2GRAY)
        mask = cv2.inRange(image, self.__class__._IN_RANGE_START, self.__class__._IN_RANGE_END)
        mask_neg = cv2.inRange(image, (0, 0, 0), (180, 180,180))
        image[mask_neg==255]=0
        
        #cv2.imshow("image_mask",image)
    
        #cv2.waitKey(0)
        #cv2.destroyAllWindows()     
        
        #image[mask!=255]=0
        gray = cv2.cvtColor(image,cv2.COLOR_BGR2GRAY)
        th3 = cv2.adaptiveThreshold(gray,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,cv2.THRESH_BINARY,3,3)
        edges = cv2.Canny(image=th3, threshold1=0, threshold2=255)
        edges = cv2.morphologyEx(edges,cv2.MORPH_CLOSE, cv2.getStructuringElement(cv2.MORPH_ELLIPSE,(3,3)),iterations=1)
        
        contours, hierarchy = cv2.findContours(gray_original, cv2.RETR_LIST, cv2.CHAIN_APPROX_SIMPLE)
        height,width,_ = np.shape(image)
        blank_image = np.zeros((height,width), np.uint8)    

        blank_image_cntrs = np.zeros((height,width,3), np.uint8)    
        
        
        #cv2.imshow("gray",gray_original)
    
        #cv2.waitKey(0)
        #cv2.destroyAllWindows()     
        
        area_max =0 
        
        trays_contours = []
        
        for p,cnt in enumerate(contours):
                    rect = cv2.minAreaRect(cnt)
                    w,h = rect[1]
                    area = w*h
                    #if area>area_max:
                    #    area_max = area
                    #ic(area_max)
                    #ic(height,width)
                    if area > self.__class__._AREA_MIN_TRAY and area < self.__class__._AREA_MAX_TRAY:
                        trays_contours.append(cnt)
                        box = cv2.boxPoints(rect)
                        box = np.int0(box)

                        cv2.drawContours(blank_image_cntrs,[cnt],-1,(0,255,0),3)  
                        M = cv2.moments(cnt)
                        cX = int(M["m10"] / M["m00"])
                        cY = int(M["m01"] / M["m00"])
                       # cv2.drawContours(output,[cnt],1,(0,0,255),-1)  
                        cv2.circle(blank_image_cntrs, (int(cX),
                                        int(cY)),
                            1, (0, 0, 255), -1)


        
        
        if self.__class__._DEBUG:
            ic(len(trays_contours))
        cnt_seeds = [0 for i in range(len(trays_contours))]
        (totalLabels, label_ids, values, centroid) = cv2.connectedComponentsWithStats(edges, self.__class__._CONNECTIVITY , cv2.CV_32S)
        
        for i in range(1, totalLabels):
            area = values[i, cv2.CC_STAT_AREA] 
        
            if (area > self.__class__._AREA_MIN) and (area < self.__class__._AREA_MAX):
                
                    componentMask = (label_ids == i).astype("uint8") * 255
                    x1 = values[i, cv2.CC_STAT_LEFT]
                    y1 = values[i, cv2.CC_STAT_TOP]
                    w = values[i, cv2.CC_STAT_WIDTH]
                    h = values[i, cv2.CC_STAT_HEIGHT]
                    pt1 = (x1, y1)
                    pt2 = (x1+ w, y1+ h)
                    (X, Y) = centroid[i]
                    cv2.circle(output, (int(X), int(Y)), 2, (0, 0, 255), -1)
                    
                    for i,cntr in enumerate(trays_contours):
                        inside = cv2.pointPolygonTest(cntr, (int(X),int(Y)), False)
                        if inside > 0.5:
                            cnt_seeds[i]+=1
                            #if self.__class__._DEBUG:
                            #    ic(cnt_seeds)
                            
                            
                            
                    blank_image = cv2.bitwise_or(blank_image, componentMask)

        if self.__class__._DEBUG:
            ic(cnt_seeds)
            
            
        for i,cntr in enumerate(trays_contours): 
              M = cv2.moments(cntr)
              cX = int(M["m10"] / M["m00"])
              cY = int(M["m01"] / M["m00"])
              blank_image_cntrs = cv2.putText(blank_image_cntrs, f'{str(cnt_seeds[i])}', (int(cX),int(cY)),  cv2.FONT_HERSHEY_SIMPLEX, 
                   2, (0,255,0), 3, cv2.LINE_AA)
                       # cv2.drawContours(output,[cnt],1,(0,0,255),-1)  
            

        #fname1 = fname + f"_{str(cnt_seeds)}.jpg"
        #cv2.imwrite(fname1,output)
    
        return output,cnt_seeds,blank_image_cntrs
        
    def init_tray_model(self):
       self.model_tray_segmentation = self.__class__._FNAME_TRAY
       self.backbone  = self.__class__._BACKBONE_TRAY
       self.n_classes = self.__class__._N_CLASSES_TRAY
       self.height = self.__class__._HGHT_TRAY
       self.width  = self.__class__._WDTH_TRAY
       self.activation  = 'sigmoid' if self.n_classes == 1 else 'softmax'
       self.model  =  sm.Unet(self.backbone, classes=self.n_classes, activation=self.activation,input_shape=(self.height, self.width, 3))
       if self.model_tray_segmentation is None or self.model_tray_segmentation == "":
           pass
       else:
           self.model.load_weights(self.model_tray_segmentation)
       

    def process_folder(self,folder_in="",folder_out=""):
        fnames = glob.glob(f"{folder_in}/*")
        dump_dir = folder_out
        
        if not os.path.exists(folder_out):
            os.makedirs(folder_out)
            
            
        for i,elem in enumerate(fnames):
            if self.__class__._DEBUG:
                ic(elem)
            start = time.time()
            image = cv2.imread(elem)
            image_copy = image.copy()
            mask_gray, mask_color = self.get_mask_from_image(image)
            
            added_image = cv2.addWeighted(image,0.6,mask_color,0.4,0)
            image[mask_gray<0.6]=(0,0,0)
            imgCombined = np.hstack([image_copy,image, mask_color,added_image,image])
            fn = os.path.join(dump_dir,str(i)+"_overlay.jpg")

            image_processed, cnt_seeds, boundaries_img = self.process_count_via_connectedComponents(image)
            fn1 = os.path.join(dump_dir,str(i)+"_seeds_counted.jpg")
            if self.__class__._DEBUG:
                ic(cnt_seeds)
            self.save_image(fn,imgCombined)
            img_with_contours = np.hstack([image_processed,boundaries_img])
            end = time.time()
            duration_secs = end - start
            ic(duration_secs)
            self.save_image(fn1,img_with_contours)

    
            
        





if __name__ == "__main__":
    counter = SeedCounter()
    counter.process_folder(folder_in = "new_test_input",folder_out = "new_test_output")
