import os, sys
from PIL import Image,ImageDraw
path = "/mnt/home/mengfanr/Arabidopsis_seeds_detect/faster_rcnn_fruits/rotate_test/draw"
os.chdir(path)
Image.MAX_IMAGE_PIXELS = 1000000000
labels = open("/mnt/home/mengfanr/Arabidopsis_seeds_detect/faster_rcnn_fruits/rotate_test/"+sys.argv[1],"r").readlines()
for root, dirs, files in os.walk(path):
    for f in files:
        im=Image.open(path+"/"+f)
        draw = ImageDraw.Draw(im)
        for seed in  labels:
            s = seed.strip().split(",")
            region = ((int(s[4]),int(s[5])),(int(s[6]),int(s[5])),(int(s[6]),int(s[7])),(int(s[4]),int(s[7])))
            draw.polygon(region,outline='green')
        im = im.save("2.jpg")
