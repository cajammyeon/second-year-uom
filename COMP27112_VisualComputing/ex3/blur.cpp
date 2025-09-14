#include <stdio.h>
#include <opencv2/core/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>

int main(int argc, char const *argv[]) {
	
	cv::Mat img;
	cv::Mat out;

	img = cv::imread(argv[1], cv::IMREAD_GRAYSCALE);

	if (img.empty()) {
		printf("Failes to load image %s\n", argv[1]);
		return -1;
	}

	// blur theimage
	cv::blur(img, out, cv::Size(30, 30));

	// setup window
	cv::namedWindow("Image", cv::WINDOW_NORMAL);
	cv::imshow("Image", out);

	// wait for a key before quitting
	cv::waitKey(0);

	return 0;
}
