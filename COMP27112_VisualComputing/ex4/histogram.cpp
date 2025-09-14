#include <stdio.h>
#include <iostream>
#include <sstream>
#include <opencv2/core/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>

const int HIST_IMG_HEIGHT = 400;
const int HIST_IMG_WIDTH = 512;

void createHistogram(cv::Mat& img, cv::Mat& hist) {
	long counts[256] = {};
	hist = cv::Mat(HIST_IMG_HEIGHT, HIST_IMG_WIDTH, CV_8UC1, 255);
	int max(0);

	// draw gridlines
	cv::rectangle(hist, cv::Point(0, HIST_IMG_HEIGHT), cv::Point(1, 0), cv::Scalar(200, 200, 200), cv::FILLED);
	cv::rectangle(hist, cv::Point(128, HIST_IMG_HEIGHT), cv::Point(129, 0), cv::Scalar(200, 200, 200), cv::FILLED);
	cv::rectangle(hist, cv::Point(256, HIST_IMG_HEIGHT), cv::Point(257, 0), cv::Scalar(200, 200, 200), cv::FILLED);
	cv::rectangle(hist, cv::Point(384, HIST_IMG_HEIGHT), cv::Point(385, 0), cv::Scalar(200, 200, 200), cv::FILLED);
	cv::rectangle(hist, cv::Point(510, HIST_IMG_HEIGHT), cv::Point(511, 0), cv::Scalar(200, 200, 200), cv::FILLED);


	// count the greyscales
	for (int i = 0; i < img.rows; i++) {
		for (int j = 0; j < img.cols; j++) {
			counts[(int)img.at<uchar>(i, j)] += 1;
		}
	}

	// check for maximum value
	for (int i = 0; i < 256; i++) {
		if (counts[i] > max) {
			max = counts[i];
		}
	}

	// normalise to maximum height
	for (int i = 0; i < 256; i++) {
		counts[i] = (long)((counts[i] / (double)max) * 400);
	}

	// draw the histogram
	for (int i = 0; i < 256; i++) {
		cv::Point top_left(i*2, HIST_IMG_HEIGHT - counts[i]);
		cv::Point bottom_right(i*2+1, HIST_IMG_HEIGHT);
		cv::rectangle(hist, top_left, bottom_right, cv::Scalar(0, 0, 0), cv::FILLED);
	}
	
}

void createThresholded(cv::Mat& img, cv::Mat& tres, int T) {
	std::cout << "Threshold value : " << cv::threshold(img, tres, T, 255, cv::THRESH_BINARY) << "\n";
}

int main(int argc, char *argv[]) {

	cv::Mat img;
	cv::Mat hist;
	cv::Mat tres;

	img = cv::imread(argv[1], cv::IMREAD_GRAYSCALE);

	// check if the image was successfully loaded
	if (img.empty()) {
		printf("Failed to load image '%s'\n", argv[1]);
		return -1;
	}

	// Create image histogram
	createHistogram(img, hist);

	// create thresholded image using OTSU
	createThresholded(img, tres, std::stoi(argv[3]));

	// show image
	cv::imshow("Histogram", hist);
	cv::imshow("Thresholded image", tres);
	cv::waitKey(0);

	// create string for saving
	std::stringstream hist_fold;
	hist_fold << "./hist_result/hist_" << argv[2] << ".jpg";
	std::stringstream thresh_fold;
	thresh_fold << "./thresh_result/thresh_" << argv[2] << ".jpg";

	// save image
	cv::imwrite(hist_fold.str(), hist);
	cv::imwrite(thresh_fold.str(), tres);
		
	return 0;
}
