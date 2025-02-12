#!/usr/bin/env python3
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""Sample code for Comp24011 SLAM lab solution

NB: The default code in non-functional; it simply avoids type errors
"""

__author__ = "s61110ab"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

import cv2
import sys

from vision_tasks_base import DMatch, VisionTasksBase

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class VisionTasks(VisionTasksBase):
    def __init__(self, *params):
        """Initialise instance by passing arguments to super class"""
        super().__init__(*params)

    def dt_matching(self, prev_image, this_image):
        """Implements feature matching based on distance thresholding

        :param prev_image: cv2 image of previous frame
        :type prev_image:  cv2.Mat == numpy.ndarray
        :param this_image: cv2 image of current frame
        :type this_image:  cv2.Mat == numpy.ndarray

        :return: keypoints of previous frame,
                 keypoints of current frame,
                 matches for feature_id descriptors
        :rtype:  list[cv2.KeyPoint],
                 list[cv2.KeyPoint],
                 list[list[vision_tasks_base.DMatch]]
        """

        # get keypoints and descriptor for comparison
        key_prev, desc_prev = super().detectAndCompute(prev_image)
        key_this, desc_this = super().detectAndCompute(this_image)
        
        brute_matcher = cv2.BFMatcher()
        matches = brute_matcher.knnMatch(desc_prev, desc_this, k = self.NUM_FEATURES)

        dt_good = []

        for i in matches :
            temp_list = []
            for j in i :
                if j.distance <= self.threshold :
                    temp_list.append(DMatch(queryIdx = j.queryIdx, trainIdx = j.trainIdx, imgIdx = j.imgIdx, distance = j.distance))
            dt_good.append(temp_list)

        sorted_match = [x for _, x in sorted(zip(key_prev, dt_good), key = lambda kp: (kp[0].pt[0], kp[0].pt[1]))]
            
        return key_prev, key_this, sorted_match

    def nn_matching(self, prev_image, this_image):
        """Implements feature matching based on nearest neighbour

        :param prev_image: cv2 image of previous frame
        :type prev_image:  cv2.Mat == numpy.ndarray
        :param this_image: cv2 image of current frame
        :type this_image:  cv2.Mat == numpy.ndarray

        :return: keypoints of previous frame,
                 keypoints of current frame,
                 matches for feature_id descriptors
        :rtype:  list[cv2.KeyPoint],
                 list[cv2.KeyPoint],
                 list[list[vision_tasks_base.DMatch]]
        """
        key_prev, desc_prev = super().detectAndCompute(prev_image)
        key_this, desc_this = super().detectAndCompute(this_image)

        brute_matcher = cv2.BFMatcher()
        matches = brute_matcher.knnMatch(desc_prev, desc_this, k = 1)

        nn_good = []

        if (self.threshold == None) :
            for i in matches :
                temp_list = []
                temp_list.append(DMatch(queryIdx = i[0].queryIdx, trainIdx = i[0].trainIdx, imgIdx = i[0].imgIdx, distance = i[0].distance))
                nn_good.append(temp_list)
        else :
            for i in matches :
                temp_list = []
                if (i[0].distance <= self.threshold) :
                    temp_list.append(DMatch(queryIdx = i[0].queryIdx, trainIdx = i[0].trainIdx, imgIdx = i[0].imgIdx, distance = i[0].distance))
                nn_good.append(temp_list)

        sorted_match = [x for _, x in sorted(zip(key_prev, nn_good), key = lambda kp: (kp[0].pt[0], kp[0].pt[1]))]
        
        return key_prev, key_this, sorted_match

    def nndr_matching(self, prev_image, this_image):
        """Implements feature matching based on nearest neighbour distance ratio

        :param prev_image: cv2 image of previous frame
        :type prev_image:  cv2.Mat == numpy.ndarray
        :param this_image: cv2 image of current frame
        :type this_image:  cv2.Mat == numpy.ndarray

        :return: keypoints of previous frame,
                 keypoints of current frame,
                 matches for feature_id descriptors
        :rtype:  list[cv2.KeyPoint],
                 list[cv2.KeyPoint],
                 list[list[vision_tasks_base.DMatch]]
        """
        key_prev, desc_prev = super().detectAndCompute(prev_image)
        key_this, desc_this = super().detectAndCompute(this_image)

        ratio = self.threshold

        brute_matcher = cv2.BFMatcher()
        matches = brute_matcher.knnMatch(desc_prev, desc_this, k = 2)

        nndr_good = []

        for m,n in matches :
            temp_list = []
            if (m.distance < ratio * n.distance) :
                temp_list.append(DMatch(queryIdx = m.queryIdx, trainIdx = m.trainIdx, imgIdx = m.imgIdx, distance = m.distance))
            nndr_good.append(temp_list)

        sorted_match = [x for _, x in sorted(zip(key_prev, nndr_good), key = lambda kp: (kp[0].pt[0], kp[0].pt[1]))]

        return key_prev, key_this, sorted_match

    def matchLocating(self, this_image, prev_image, prev_feature):
        """Calculates coordinates of a feature and
           its matches under the current matching algorithm

        :param this_image: cv2 image of current frame
        :type this_image:  cv2.Mat == numpy.ndarray
        :param prev_image: cv2 image of previous frame
        :type prev_image:  cv2.Mat == numpy.ndarray
        :param prev_feature: feature_id for previous frame descriptor
        :type prev_feature:  int

        :return: coordinate of feature in previous frame,
                 coordinates for feature matches in current frame
        :rtype:  tuple[int,int],
                 list[tuple[int,int]]
        """

        key_prev, key_this, good = self.matching_algo(prev_image, this_image)

        match_list = []

        if (len(good) < prev_feature) :
            return (0, 0), []
        
        if len(good[prev_feature]) > 0 :
            for i in good[prev_feature] :
                match_list.append((int(key_this[i.trainIdx].pt[0]), int(key_this[i.trainIdx].pt[1])))
        
        key_prev_sorted = sorted(key_prev, key = lambda kp: (kp.pt[0], kp.pt[1]))
        keypoint = (int(key_prev_sorted[prev_feature].pt[0]), int(key_prev_sorted[prev_feature].pt[1]))
        return keypoint, match_list

if __name__ == "__main__" :
    test_match = VisionTasks('dt', 401.1)
    prev_image = cv2.imread("/home/MyKITTI/gray/00/image_0/000007.png")
    this_image = cv2.imread("/home/MyKITTI/gray/00/image_0/000008.png")
    key_prev, key_this, matches = test_match.dt_matching(prev_image, this_image)
    print(matches[27])
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# vim:set et sw=4 ts=4: