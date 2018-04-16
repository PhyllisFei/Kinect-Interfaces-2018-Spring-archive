import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import gab.opencv.*;
import controlP5.*;


OpenCV opencv;
ControlP5 cp5;

Kinect2 kinect2;
PImage depthImg;

int thresholdMin = 0;
int thresholdMax = 4499;


void setup() {
  size(512, 424, P2D);

  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();

  // Blank image
  depthImg = new PImage(kinect2.depthWidth, kinect2.depthHeight, ARGB);
  
  // Blank OpenCV Image
  opencv = new OpenCV(this, depthImg);

  // add gui
  int sliderW = 100;
  int sliderH = 20;
  cp5 = new ControlP5( this );
  cp5.addSlider("thresholdMin")
    .setPosition(10, 40)
    .setSize(sliderW, sliderH)
    .setRange(1, 4499)
    .setValue(0)
    ;
  cp5.addSlider("thresholdMax")
    .setPosition(10, 70)
    .setSize(sliderW, sliderH)
    .setRange(1, 4499)
    .setValue(4499)
    ;
}


void draw() {
  background(0);

  int[] rawDepth = kinect2.getRawDepth();
  depthImg.loadPixels();
  for (int i=0; i < rawDepth.length; i++) {
    int depth = rawDepth[i];

    if (depth >= thresholdMin
      && depth <= thresholdMax
      && depth != 0) {

      float w = map(depth, thresholdMin, thresholdMax, 255, 100);

      depthImg.pixels[i] = color(w);
    } else {
      depthImg.pixels[i] = color(0,0);
    }
  }
  depthImg.updatePixels();


  opencv.loadImage(depthImg);
  opencv.gray();
  opencv.threshold(50);
  opencv.erode();
  opencv.dilate();
  opencv.dilate();
  opencv.erode();
  
  
  image(kinect2.getDepthImage(), 0, 0);
  //image(depthImg, 0, 0);
  
 
  float sumX = 0;
  float sumY = 0;
  int count = 0;
  
  PImage img = opencv.getSnapshot();
  img.loadPixels();
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      int index = x + y * img.width;
      float w = red(img.pixels[index]);
      
      if (w > 100) {
        sumX += x;
        sumY += y;
        count++;
      }
    }
  }

  image(img, 0, 0);
  
  
  // get the center position
  float avgX = 0;
  float avgY = 0;
  if (count > 0) {
    avgX = sumX / count;
    avgY = sumY / count;
  }

  // draw the center position
  stroke(0, 255, 0);
  line(avgX, 0, avgX, height);
  line(0, avgY, width, avgY);


  fill(255);
  text(frameRate, 10, 20);
}
