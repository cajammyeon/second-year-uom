#!/usr/bin/env python3
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""Python code for Comp24011 SLAM lab"""

__author__    = "uoip, mbaxjrb2, a21674fl"
__copyright__ = "Copyright 2024; please do not distribute!"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

import dataclasses
import sys
import cv2

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# serialisable version of cv2.DMatch
@dataclasses.dataclass()
class DMatch:
    queryIdx: int
    trainIdx: int
    imgIdx: int
    distance: float

    # convert back into cv2.DMatch object
    def cv2_DMatch(self):
        return cv2.DMatch(
                self.queryIdx, self.trainIdx, self.imgIdx, self.distance )

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class VisionTasksBase:
    # parameters and initialisation for vision tasks
    NUM_FEATURES = 1500
    MATCHING_ALGOS = "dt nn nndr".split()

    def __init__(self, matching_algo=None, threshold=None):
        self.matching_algo = None
        for algo in self.MATCHING_ALGOS:
            if algo == matching_algo:
                self.matching_algo = getattr(self, f"{algo}_matching")
                break
        self.threshold = threshold
        # create a SIFT detector for vision tasks
        self.detector = cv2.SIFT_create(nfeatures=self.NUM_FEATURES)

    # wrapper providing SIFT detect & compute functionality
    def detectAndCompute(self, img, mask=None):
        kp, des = self.detector.detectAndCompute(img, mask)
        return kp, des

    # implementation of feature tracking for visual odometry
    LK_PARAMS = dict(
        winSize  = (21, 21),
        criteria = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 30, 0.01))

    def featureTracking(self, this_img, prev_img, prev_pts):
        this_pts, status, errors = cv2.calcOpticalFlowPyrLK(
                prev_img, this_img, prev_pts, None, **self.LK_PARAMS)
        status = status.reshape(status.shape[0])
        return prev_pts[status == 1], this_pts[status == 1]

    # interface of feature matching for visual odometry
    def featureMatching(self, this_img, prev_img, prev_feature):
        prev_kp, this_kp, matches = self.matching_algo(prev_img, this_img)
        if prev_feature < len(prev_kp):
            feature_matches = [ m.cv2_DMatch() for m in matches[prev_feature] ]
        else:
            feature_matches = []
        return prev_kp, this_kp, feature_matches

    # concrete sub-classes must implement feature matching algorithms
    def dt_matching(self, prev_img, this_img):
        raise NotImplementedError
    def nn_matching(self, prev_img, this_img):
        raise NotImplementedError
    def nndr_matching(self, prev_img, this_img):
        raise NotImplementedError

    # concrete sub-classes must calculate feature matching coordinates
    def matchLocating(self, this_img, prev_img, prev_feature):
        raise NotImplementedError

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# vim:set et sw=4 ts=4:
