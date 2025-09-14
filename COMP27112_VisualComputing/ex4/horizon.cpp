#include <iostream>
#include <sstream>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <cmath>

cv::Mat img;
cv::Mat gray;

cv::Mat canny;
cv::Mat hough;
cv::Mat short_line_rem;
cv::Mat horizontal_line;
cv::Mat horizon_drawn;

//Polynomial regression function
std::vector<double> fitPoly(std::vector<cv::Point> points, int n) {
  //Number of points
  int nPoints = points.size();

  //Vectors for all the points' xs and ys
  std::vector<float> xValues = std::vector<float>();
  std::vector<float> yValues = std::vector<float>();

  //Split the points into two vectors for x and y values
  for(int i = 0; i < nPoints; i++)
  {
    xValues.push_back(points[i].x);
    yValues.push_back(points[i].y);
  }

  //Augmented matrix
  double matrixSystem[n+1][n+2];
  for(int row = 0; row < n+1; row++)
  {
    for(int col = 0; col < n+1; col++)
    {
      matrixSystem[row][col] = 0;
      for(int i = 0; i < nPoints; i++)
        matrixSystem[row][col] += pow(xValues[i], row + col);
    }

    matrixSystem[row][n+1] = 0;
    for(int i = 0; i < nPoints; i++)
      matrixSystem[row][n+1] += pow(xValues[i], row) * yValues[i];

  }

  //Array that holds all the coefficients
  double coeffVec[n+2] = {};  // the "= {}" is needed in visual studio, but not in Linux

  //Gauss reduction
  for(int i = 0; i <= n-1; i++)
    for (int k=i+1; k <= n; k++)
    {
      double t=matrixSystem[k][i]/matrixSystem[i][i];

      for (int j=0;j<=n+1;j++)
        matrixSystem[k][j]=matrixSystem[k][j]-t*matrixSystem[i][j];

    }

  //Back-substitution
  for (int i=n;i>=0;i--)
  {
    coeffVec[i]=matrixSystem[i][n+1];
    for (int j=0;j<=n+1;j++)
      if (j!=i)
        coeffVec[i]=coeffVec[i]-matrixSystem[i][j]*coeffVec[j];

    coeffVec[i]=coeffVec[i]/matrixSystem[i][i];
  }

  //Construct the vector and return it
  std::vector<double> result = std::vector<double>();
  for(int i = 0; i < n+1; i++)
    result.push_back(coeffVec[i]);
  return result;
}

//Returns the point for the equation determined
//by a vector of coefficents, at a certain x location
cv::Point pointAtX(std::vector<double> coeff, double x) {
  double y = 0;
  for(int i = 0; i < coeff.size(); i++)
  y += pow(x, i) * coeff[i];
  return cv::Point(x, y);
}

void canny_image(int lower_thresh, int upper_thresh) {
  cv::Canny(gray, canny, lower_thresh, upper_thresh, 3, true);
  cv::imshow("Canny result", canny);
}

std::vector<cv::Vec4i> prob_hugh(int threshold) {
  std::vector<cv::Vec4i> lines;
  cv::HoughLinesP(canny, lines, 1, CV_PI/180, threshold);

  for (cv::Vec4i line: lines) {
    cv::line(hough, cv::Point(line[0], line[1]), cv::Point(line[2], line[3]), cv::Scalar(0, 0, 255), 2, cv::LINE_AA);
  }

  cv::imshow("Hough result", hough);
  return lines;
}

std::vector<cv::Vec4i> remove_short_line(int threshold, std::vector<cv::Vec4i> line_vector) {
  std::vector<cv::Vec4i> result_vector;
  for (cv::Vec4i line: line_vector) {
    if (std::sqrt(static_cast<double>((line[0] - line[2]) * (line[0] - line[2]) + (line[1] - line[3]) * (line[1] - line[3]))) > threshold) {
      result_vector.push_back(line);
    }
  }

  for (cv::Vec4i line: result_vector) {
    cv::line(short_line_rem, cv::Point(line[0], line[1]), cv::Point(line[2], line[3]), cv::Scalar(0, 0, 255), 2, cv::LINE_AA);
  }

  cv::imshow("Short line removal result", short_line_rem);
  return result_vector;
}

std::vector<cv::Vec4i> remove_vertical_line(std::vector<cv::Vec4i> line_vector) {
  std::vector<cv::Vec4i> result_vector;
  for (cv::Vec4i line: line_vector) {
    if (line[0] == line[2]) {
      continue;
    }
    double angle = std::atan2(line[0] - line[2], line[1] - line[3]);
    if ((angle >= M_PI_4 && angle <= 3*(M_PI_4)) || (angle <= -M_PI_4 && angle >= -3*(M_PI_4))) {
      result_vector.push_back(line);
    }
  }
  
  for (cv::Vec4i line: result_vector) {
    cv::line(horizontal_line, cv::Point(line[0], line[1]), cv::Point(line[2], line[3]), cv::Scalar(0, 0, 255), 2, cv::LINE_AA);
  }
  
  cv::imshow("Vertical line removal result", horizontal_line);
  return result_vector;
}

std::vector<cv::Point> lines_to_points(std::vector<cv::Vec4i> line_vector) {
  std::vector<cv::Point> points;
  for (cv::Vec4i line: line_vector) {
    points.push_back(cv::Point(line[0], line[1]));
    points.push_back(cv::Point(line[2], line[3]));
  }
  return points;
}

void draw_horizon(std::vector<double> coeff) {
  for (int i = 0; i <= horizon_drawn.cols; i++) {
    cv::circle(horizon_drawn, pointAtX(coeff, (double)i), 1, cv::Scalar(0, 0, 255), cv::FILLED);
  }
  cv::imshow("Horizon drawn", horizon_drawn);
}

int main(int argc, char const *argv[]) {

  img = cv::imread(argv[1]);

  // check if the image was successfully loaded
	if (img.empty()) {
		printf("Failed to load image '%s'\n", argv[1]);
		return -1;
	}

  // change to gray
  cv::cvtColor(img, gray, cv::COLOR_BGR2GRAY);

  // blur the image
  cv::GaussianBlur(gray, gray, cv::Size(7, 7), 0, 0);
  cv::imwrite("blur_horizon2.jpg", gray);

  // apply canny filter on image - use wrapper method
  canny_image(std::atoi(argv[4]), std::atoi(argv[5]));

  // apply Hough line transform
  hough = img.clone();
  std::vector<cv::Vec4i> lines_detected = prob_hugh(std::atoi(argv[2]));

  // remove short lines
  short_line_rem = img.clone();
  std::vector<cv::Vec4i> longer_lines = remove_short_line(std::atoi(argv[3]), lines_detected);

  // remove vertical lines
  horizontal_line = img.clone();
  std::vector<cv::Vec4i> vertical_lines_removed = remove_vertical_line(longer_lines);

  // change the lines to points
  std::vector<cv::Point> predicted_points = lines_to_points(vertical_lines_removed);

  // polynomial regression
  std::vector<double> line_coeff = fitPoly(predicted_points, 2);

  // draw the horizon
  horizon_drawn = img.clone();
  draw_horizon(line_coeff);

  cv::waitKey(0);

  // create filename
  std::stringstream canny_edge_name;
  canny_edge_name << "./canny/canny_" << argv[1] << ".jpg";
  std::stringstream hough_line_name;
  hough_line_name << "./hough/hough_" << argv[1] << ".jpg";
  std::stringstream short_remo_name;
  short_remo_name << "./short/short_" << argv[1] << ".jpg";
  std::stringstream horiz_line_name;
  horiz_line_name << "./horizontal/horizontal_" << argv[1] << ".jpg";
  std::stringstream horiz_draw_name;
  horiz_draw_name << "./horizon_drawn/horizon_" << argv[1] << ".jpg";

  // save the image
  cv::imwrite(canny_edge_name.str(), canny);
  cv::imwrite(hough_line_name.str(), hough);
  cv::imwrite(short_remo_name.str(), short_line_rem);
  cv::imwrite(horiz_line_name.str(), horizontal_line);
  cv::imwrite(horiz_draw_name.str(), horizon_drawn);

  return 0;
}

// image threshold length lower upper

// horizon1
// canny lower thresh - 135
// canny upper thresh - 140
// rho - 1
// theta - CV_PI / 180
// threshold - 80
// length - 15

// horizon2
// Gaussian Blur (7,7)
// canny lower thresh - 130
// canny upper thresh - 130
// rho - 1
// theta - CV_PI / 180
// threshold - 85
// length - 3

// horizon3
// canny lower thresh - 100
// canny upper thresh - 200
// rho - 1
// theta - CV_PI / 180
// threshold - 50
// length - 15