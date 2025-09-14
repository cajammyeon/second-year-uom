#include <stdio.h>
#include <opencv2/core/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>

cv::Mat img;
cv::Mat out;

void thresh_onchange(int val, void* userdata) {
	// param 1 - input image
	// param 2 - output image
	// param 3 - threshold
	// param 4 - value to be mapped to
	// param 5 - type of threholding
	cv::threshold(img, out, val, 255, cv::THRESH_BINARY);
	cv::imshow("Result", out);
}

int main(int argc, char const *argv[]) {
	img = cv::imread(argv[1], cv::IMREAD_GRAYSCALE);

	if (img.empty()) {
		printf("Failes to load image %s\n", argv[1]);
		return -1;
	}

	cv::namedWindow("Result", cv::WINDOW_NORMAL);

	// param 1 - name of value being varied
	// param 2 - window to attach the trackbar to
	// param 3 - address of a variable to receive the trackbar value
	// param 4 - maximum value
	// param 5 - a function that will be called whenever the trackbar is moved
	cv::createTrackbar("Threshold", "Result", NULL, 255, thresh_onchange);

	thresh_onchange(0, NULL);

	cv::waitKey(0);

	return 0;
}

