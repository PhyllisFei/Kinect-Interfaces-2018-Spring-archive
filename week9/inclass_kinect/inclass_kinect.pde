import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;

Kinect2 kinect;
PImage depthImg;

float minDepth = 1000;
float maxDepth = 2000;


void setup() {
  size(512, 424, P2D); // 512 * 424

  kinect = new Kinect2(this);

  //kinect.initVideo();
  kinect.initDepth();
  //kinect.initIR();
  //kinect.initRegistered();

  kinect.initDevice();

  depthImg = createImage(kinect.depthWidth, kinect.depthHeight, ARGB);
}

void draw() {
  background(0);

  int[] rawDepth = kinect.getRawDepth(); // rawDepth.length = 512*424
  int w = kinect.depthWidth;
  int h = kinect.depthHeight;

  depthImg.loadPixels();
  for (int i = 0; i < rawDepth.length; i ++) {
    int x = floor (i / w);
    int y = i % w;

    if (rawDepth[i] > minDepth && rawDepth[i] < maxDepth) {
      float r = map(rawDepth[i], minDepth, maxDepth, 255, 0); // map 0 - 4499 to 0 - 255
      float b = map(rawDepth[i], minDepth, maxDepth, 0, 255); // map 0 - 4499 to 0 - 255
      depthImg.pixels[i] = color(r, 0, b);
    } else {
      depthImg.pixels[i] = color(0, 0);
    }
  }
  depthImg.updatePixels();

  image(kinect.getDepthImage(), 0, 0);
  image(depthImg, 0, 0);
}

void mousePressed() {
  minDepth = map(mouseX, 0, width, 1, 4499);
}
void mouseDragged() {
  maxDepth = map(mouseX, 0, width, 1, 4499);
}
