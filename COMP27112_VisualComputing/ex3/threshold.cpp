#include <stdio.h>
#include <opencv2/core/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>

int main(int argc, char const *argv[]) {
	
	cv::Mat img;
	cv::Mat out;
	int T = 100;

	img = cv::imread(argv[1], cv::IMREAD_GRAYSCALE);

	if (img.empty()) {
		printf("Failes to load image %s\n", argv[1]);
		return -1;
	}

	// threshold the image
	cv::threshold(img, out, T, 255, cv::THRESH_BINARY);

	// setup window
	cv::namedWindow("Image", cv::WINDOW_NORMAL);
	cv::imshow("Image", out);

	// wait for a key before quitting
	cv::waitKey(0);

	return 0;
}
