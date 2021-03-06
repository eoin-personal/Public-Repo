ffmpeg = "C:/Dev/FFMPEG/bin/ffmpeg.exe"

import os
from os.path import exists
import glob
import argparse


parser = argparse.ArgumentParser()
parser.add_argument("in_file", help="give me a sequence file path eg. c:/tmp/myfile.001.exr")
args = parser.parse_args()

def seq2Vid(_input):
    # Scraping info from input files
    dir = os.path.dirname(_input)                       # get directory
    filename = os.path.basename(_input).split(".")[0]   # just filename no frames or extension
    ext = os.path.basename(_input).split(".")[2]

    n = len(os.path.basename(_input).split(".")[1])     # Number of paddings

    fileList = (glob.glob(dir + "/*." + ext))           # get all files by ext
    fileList.sort()                                     # organise files by order

    startNum = int(os.path.basename(fileList[0]).split(".")[1])

    # Specefiy output info
    TargetDirList = dir.split("\\")
    TargetDir = TargetDirList[0] + "/" + TargetDirList[1] + "/" + TargetDirList[2] + "/RenderedShots/Tests/"
    outputPath = TargetDir + filename + "_userGenerated.mp4"
    ffmpeg_args = " -apply_trc linear -r 24 -start_number " + str(startNum) + " -i " + dir + "/" + filename + "." + "%0" + str(n) + "d." + ext + " -vcodec libx264 -crf 25 " + outputPath
    execString = (ffmpeg +ffmpeg_args)
    execString = execString.replace("/","\\")           # swaps fwdslashes for backslashes
    if exists(outputPath):
        os.remove(outputPath)
    if not os.path.exists(TargetDir):
        os.makedirs(TargetDir)
    os.system(execString)
    os.startfile(TargetDir)

seq2Vid(args.in_file)

