import cv2
import numpy as np
import pylab as plt
from glob import glob
import argparse
import os
import pickle as pkl
import train
import math


def create_features(img):

    img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    features, _ = train.create_features(img, img_gray, label=None, train=False)

    return features

def compute_prediction(img, model):

    border = 5 # (haralick neighbourhood - 1) / 2
    sp=img.shape
    img = cv2.copyMakeBorder(img, top=border, bottom=border, \
                                  left=border, right=border, \
                                  borderType = cv2.BORDER_CONSTANT, \
                                  value=[0, 0, 0])

    features = create_features(img)
    predictions = model.predict(features.reshape(-1, features.shape[1]))
    pred_size = int(math.sqrt(features.shape[0]))
    inference_img = predictions.reshape(sp[0],sp[1])

    return inference_img

def infer_images(image_dir, model_path, output_dir):

    filelist = glob(os.path.join(image_dir,'*.jpg'))

    print ('[INFO] Running inference on %s test images' %len(filelist))

    model = pkl.load(open( model_path, "rb" ) )

    for file in filelist:
        print ('[INFO] Processing images:', os.path.basename(file))
        inference_img = compute_prediction(cv2.imread(file, 1), model)
        cv2.imwrite(os.path.join(output_dir, os.path.basename(file)), inference_img)

def main(image_dir, model_path, output_dir):

    infer_images(image_dir, model_path, output_dir)

if __name__ == '__main__':

    image_dir = "slice/test/img/"
    model_path = "model/seg.pkl"
    output_dir = "output/"
    main(image_dir, model_path, output_dir)
