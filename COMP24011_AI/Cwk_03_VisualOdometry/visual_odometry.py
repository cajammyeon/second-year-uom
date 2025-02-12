#!/usr/bin/env python3
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"""Python code for Comp24011 SLAM lab"""

__author__    = "uoip, mbaxjrb2, a21674fl"
__copyright__ = "Copyright 2024; please do not distribute!"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

import os.path
import sys
import cv2
import numpy as np

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class PinholeCamera:
    def __init__(self,
                 width=1241.0, height=376.0, # specialized for KITTI dataset
                 fx=718.8560, fy=718.8560,
                 cx=607.1928, cy=185.2157,
                 k1=0.0, k2=0.0, p1=0.0, p2=0.0, k3=0.0):
        self.width = width
        self.height = height
        self.fx = fx
        self.fy = fy
        self.cx = cx
        self.cy = cy
        self.distortion = (abs(k1) > 0.0000001)
        self.d = [k1, k2, p1, p2, k3]

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class VisualOdometry:
    STAGE_FIRST_FRAME = 0
    STAGE_SECOND_FRAME = 1
    STAGE_NORMAL_FRAME = 2
    BGR_RED = (0, 0, 255)
    BGR_GREEN = (0, 255, 0)

    def __init__(self, vt, cam, dataset_path):
        self.vt = vt
        self.cam = cam
        self.dataset_path = dataset_path
        #
        self.frame_stage = self.STAGE_FIRST_FRAME
        self.frame_cur = None
        self.frame_ref = None
        self.pt_ref = None
        self.pt_cur = None
        self.R = None
        self.t = None
        self.focal = cam.fx
        self.pp = (cam.cx, cam.cy)
        self.X, self.Y, self.Z = 0, 0, 0
        self.annotations = self.getAnnotations()
        self.traj = np.zeros((600,600,3), dtype=np.uint8)

    def getAnnotations(self):
        path = os.path.join(self.dataset_path, 'poses', '00.txt')
        with open(path) as f:
            return f.readlines()

    def getFrameScale(self, frame_id): # specialized for KITTI dataset
        ss = self.annotations[frame_id-1].strip().split()
        x_prev = float(ss[3])
        y_prev = float(ss[7])
        z_prev = float(ss[11])
        ss = self.annotations[frame_id].strip().split()
        self.X = float(ss[3])
        self.Y = float(ss[7])
        self.Z = float(ss[11])
        return np.sqrt(
                (self.X-x_prev)**2 + (self.Y-y_prev)**2 + (self.Z-z_prev)**2)

    def getFrame(self, frame_id):
        path = os.path.join(self.dataset_path, 'gray', '00', 'image_0',
                            f"{frame_id:06d}.png")
        img = cv2.imread(path, 0)
        assert img.ndim==2, f"Frame {frame_id}: dataset image isn't grayscale"
        assert img.shape[0]==self.cam.height and img.shape[1]==self.cam.width, \
                f"Frame {frame_id}: geometry doesn't match the camera model"
        return img

    def processFirstFrame(self):
        kp, _ = self.vt.detectAndCompute(self.frame_cur)
        self.pt_cur = np.array([x.pt for x in kp], dtype=np.float32)

    def processSecondFrame(self):
        self.pt_ref, self.pt_cur = self.vt.featureTracking(
                self.frame_cur, self.frame_ref, self.pt_ref)
        E, mask = cv2.findEssentialMat(
                self.pt_cur, self.pt_ref, focal=self.focal, pp=self.pp,
                method=cv2.RANSAC, prob=0.999, threshold=1.0)
        _, self.R, self.t, mask = cv2.recoverPose(
                E, self.pt_cur, self.pt_ref, focal=self.focal, pp=self.pp)

    def processNormalFrame(self, frame_id):
        self.pt_ref, self.pt_cur = self.vt.featureTracking(
                self.frame_cur, self.frame_ref, self.pt_ref)
        E, mask = cv2.findEssentialMat(
                self.pt_cur, self.pt_ref, focal=self.focal, pp=self.pp,
                method=cv2.RANSAC, prob=0.999, threshold=1.0)
        _, R, t, mask = cv2.recoverPose(
                E, self.pt_cur, self.pt_ref, focal=self.focal, pp=self.pp)
        absolute_scale = self.getFrameScale(frame_id)
        if absolute_scale > 0.1:
            self.t += absolute_scale*self.R.dot(t)
            self.R = R.dot(self.R)
        if self.pt_ref.shape[0] < self.vt.NUM_FEATURES:
            kp, _ = self.vt.detectAndCompute(self.frame_cur)
            self.pt_cur = np.array([x.pt for x in kp], dtype=np.float32)

    def processFrame(self, frame_id):
        self.pt_ref = self.pt_cur
        self.frame_ref = self.frame_cur
        self.frame_cur = self.getFrame(frame_id)
        if self.frame_stage == self.STAGE_NORMAL_FRAME:
            self.processNormalFrame(frame_id)
        elif self.frame_stage == self.STAGE_SECOND_FRAME:
            self.processSecondFrame()
            self.frame_stage = self.STAGE_NORMAL_FRAME
        elif self.frame_stage == self.STAGE_FIRST_FRAME:
            self.pt_ref = None
            self.frame_ref = None
            self.processFirstFrame()
            self.frame_stage = self.STAGE_SECOND_FRAME
        else:
            raise RuntimeError(f"Invalid frame stage: {self.frame_stage}")

    def jumpToFrame(self, frame_id):
        self.frame_stage = self.STAGE_FIRST_FRAME
        for i in set([ max(0,frame_id-1), frame_id ]):
            sys.stderr.write(f"\rProcessing frame {i}")
            sys.stderr.flush()
            self.processFrame(i)
        sys.stderr.write("\n")

    def driveToFrame(self, frame_id, show=False):
        self.frame_stage = self.STAGE_FIRST_FRAME
        for i in range(frame_id+1):
            sys.stderr.write(f"\rProcessing frame {i}")
            sys.stderr.flush()
            self.processFrame(i)
            if show:
                self.showDrive(i==frame_id)
        sys.stderr.write("\n")

    def showDrive(self, last):
        if self.frame_stage == self.STAGE_NORMAL_FRAME:
            x, y, z = (float(v) for v in self.t[0:3])
        else:
            x, y, z = 0., 0., 0.
        draw_x, draw_y = int(x)+290, int(z)+90
        true_x, true_y = int(self.X)+290, int(self.Z)+90
        cv2.circle(self.traj, (draw_x,draw_y), 1, self.BGR_RED, 1)
        cv2.circle(self.traj, (true_x,true_y), 1, self.BGR_GREEN, 1)
        wins = [ "Road Facing Camera", "Trajectory" ]
        cv2.imshow(wins[0], self.frame_cur)
        cv2.imshow(wins[1], self.traj)
        cv2.displayOverlay(wins[1],
                           f"Coordinates: x={x:.2f}m y={y:.2f}m z={z:.2f}m")
        if last:
            for win in wins:
                cv2.displayStatusBar(win, "Press any key to quit")
            cv2.waitKey(0)
            cv2.destroyAllWindows()
        else:
            cv2.waitKey(1)

    def showImage(self, win, img):
        cv2.namedWindow(win, cv2.WINDOW_NORMAL)
        cv2.moveWindow(win, 0, 0)
        cv2.resizeWindow(win, *reversed(self.frame_cur.shape[:2]))
        cv2.imshow(win, img)
        cv2.displayStatusBar(win, "Press any key to quit")
        cv2.waitKey(0)
        cv2.destroyAllWindows()

    def showFeatureMatches(self, feature_id, show=True):
        assert self.frame_stage == self.STAGE_NORMAL_FRAME, \
                "Feature matches only available from second frame"
        kp_ref, kp_cur, feature_matches = self.vt.featureMatching(
                self.frame_cur, self.frame_ref, feature_id)
        img = cv2.drawMatchesKnn(
                self.frame_ref, kp_ref, self.frame_cur, kp_cur,
                [feature_matches], None, flags=2)
        if show:
            self.showImage("Feature Matches", img)
        return img

    def drawFeatureMatches(self, feature_id, show=True):
        assert self.frame_stage == self.STAGE_NORMAL_FRAME, \
                "Feature matches only available from second frame"
        loc_feature, loc_matches = self.getFeatureMatches(feature_id)
        img_feature = cv2.cvtColor(self.frame_ref, cv2.COLOR_GRAY2BGR)
        img_matches = cv2.cvtColor(self.frame_cur, cv2.COLOR_GRAY2BGR)
        cv2.circle(img_feature, loc_feature, 10, self.BGR_GREEN, 2)
        for pos in loc_matches:
            cv2.circle(img_matches, pos, 10, self.BGR_RED, 2)
        img = cv2.hconcat([img_feature, img_matches])
        if show:
            self.showImage("Match Locations", img)
        return img

    def getFeatureMatches(self, feature_id):
        assert self.frame_stage == self.STAGE_NORMAL_FRAME, \
                "Feature matches only available from second frame"
        loc_feature, loc_matches = self.vt.matchLocating(
                self.frame_cur, self.frame_ref, feature_id)
        return loc_feature, loc_matches

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# vim:set et sw=4 ts=4:
