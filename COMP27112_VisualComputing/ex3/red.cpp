#include <stdio.h>
#include <opencv2/core/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>

int main(int argc, char *argv[]) {

	cv::Mat img;

	img = cv::imread(argv[1]);

	if (img.empty()) {
		printf("Fail to load image");
		return -1;
	}

	for (int r = 0; r < img.rows; r++) {
		for (int c = 0; c < img.cols; c++) {
			cv::Vec3b px = img.at<cv::Vec3b>(r, c);
			px[0] = 0; //RED
			px[1] = 0; //GREEN
			img.at<cv::Vec3b>(r, c) = px;
		}
	}

	cv::namedWindow("Red", cv::WINDOW_NORMAL);
	cv::imshow("Red", img);
	
	cv::waitKey(0);

	return 0;
}
