#!/usr/bin/env python3
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""Python code for Comp24011 SLAM lab"""

__author__    = "mbaxjrb2, a21674fl"
__copyright__ = "Copyright 2023; please do not distribute!"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

import argparse
import os.path
import sys
import cv2

from visual_odometry import PinholeCamera, VisualOdometry
from vision_tasks import VisionTasks

MAX_FRAME = 500
OPENCV_PNG = os.path.join(
        os.path.relpath(os.path.dirname(__file__)), 'opencv_visual.png')
CUSTOM_PNG = os.path.join(
        os.path.relpath(os.path.dirname(__file__)), 'custom_visual.png')
DATASET_PATH = os.path.expanduser('~/MyKITTI')

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class RunOdometry:
    def __init__(self,
             matching_algo=None, threshold=None, dataset_path=DATASET_PATH):
        vt = VisionTasks(matching_algo, threshold)
        cam = PinholeCamera()
        self.vo = VisualOdometry(vt, cam, dataset_path)

    def show_drive(self, frame_id=MAX_FRAME):
        self.vo.driveToFrame(frame_id, True)

    def show_matches(self, frame_id, feature_id):
        self.vo.jumpToFrame(frame_id+1)
        visual = self.vo.showFeatureMatches(feature_id, True)
        cv2.imwrite(OPENCV_PNG, visual)

    def draw_matches(self, frame_id, feature_id):
        self.vo.jumpToFrame(frame_id+1)
        visual = self.vo.drawFeatureMatches(feature_id, True)
        cv2.imwrite(CUSTOM_PNG, visual)

    def get_matches(self, frame_id, feature_id):
        self.vo.jumpToFrame(frame_id+1)
        return self.vo.getFeatureMatches(feature_id)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def main(*argv):
    def add_ro_arguments(sp, title, *args, **kwargs):
        p = sp.add_parser(title, *args, **kwargs)
        p.add_argument(
            '-a', '--algorithm', action='store', required=True, type=str,
            choices=VisionTasks.MATCHING_ALGOS,
            help="name of the algorithm used for feature matching")
        p.add_argument(
            '-t', '--threshold', action='store', default=None, type=float,
            required=not 'nn' in sys.argv,
            help="decimal value of threshold for feature matching " \
                +"(option not required for nn algorithm)")
        p.add_argument(
            'frame_id', type=int,
            help=f"index of chosen frame (0 to {MAX_FRAME-1})")
        p.add_argument(
            'feature_id', type=int,
            help=f"index of chosen feature (0 to {VisionTasks.NUM_FEATURES-1})")
        return p
    #
    p0 = argparse.ArgumentParser()
    p0.add_argument(
            '-d', '--dataset', action='store', default=DATASET_PATH,
            required=not os.path.exists(DATASET_PATH),
            help="path to KITTI dataset directory " \
                +f"(option required unless dataset is located at {DATASET_PATH})")
    sp = p0.add_subparsers(
            dest='command', required=True,
            description="select which odometry command to run")
    #
    p1 = sp.add_parser(
            'show_drive',
            help="show the car camera view and the calculated trajectory")
    p1.add_argument(
            'frame_id', nargs='?', default=MAX_FRAME, type=int,
            help=f"index of frame to stop visualisation (0 to {MAX_FRAME})")
    #
    add_ro_arguments(
            sp, 'show_matches',
            help="show matches for frame feature using OpenCV " \
                +f"(and save this image as {OPENCV_PNG})")
    add_ro_arguments(
            sp, 'draw_matches',
            help="draw matches for frame feature using calculated positions " \
                +f"(and save this image as {CUSTOM_PNG})")
    add_ro_arguments(
            sp, 'get_matches',
            help="get calculated positions for matches of frame feature")
    #
    config = p0.parse_args(*argv)
    params = []
    for attr in "algorithm threshold dataset".split():
        params.append(getattr(config, attr, None))
    args = []
    for attr in "frame_id feature_id".split():
        if hasattr(config, attr):
            args.append(getattr(config, attr))
    print("vo params: {}".format( (*params,) ))
    print("debug run: {}{}".format(config.command, (*args,)))
    run = RunOdometry(*params)
    app = getattr(run, config.command)
    ret = app(*args)
    print("ret value:", ret)
    try:
      cnt = len(ret)
      print("ret count:", cnt)
    except TypeError:
      pass

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if __name__ == '__main__':
    main(sys.argv[1:])

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# vim:set et sw=4 ts=4:
