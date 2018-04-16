// IMA NYU Shanghai
// Kinetic Interfaces
// MOQN
// Mar 28 2018


import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import controlP5.*;

ControlP5 cp5;
Slider2D rotation;
Range depthRange;


Kinect2 kinect2;
PImage depthImg;

int resolution = 3;
int thresholdMin = 1;
int thresholdMax = 4499;
int pointSize = 1;

// GUI
int guiX = 10;
int guiY = 150;
int sliderW = 100;
int sliderH = 20;
int sliderGap = sliderH + 10;

void setup() {
  size(800, 600, P3D);
  kinect2 = new Kinect2(this);

  kinect2.initDepth();
  kinect2.initDevice();

  depthImg = new PImage(kinect2.depthWidth, kinect2.depthHeight, ARGB);

  // GUI
  cp5 = new ControlP5(this);
  depthRange = cp5.addRange("DepthRange")
    .setBroadcast(false)
    .setPosition(guiX, guiY + sliderGap * 0)
    .setSize (sliderW * 2, sliderH)
    .setRange(1, 4499)
    .setRangeValues(1, 4499)
    .setHandleSize(30)
    ;
  /*
   cp5.addSlider("thresholdMin")
   .setPosition(guiX, guiY + sliderGap * 0)
   .setRange(1, 4499)
   .setSize(sliderW, sliderH)
   .setValue(1)
   .setSliderMode(Slider.FLEXIBLE)
   ;
   cp5.addSlider("thresholdMax")
   .setPosition(guiX, guiY + sliderGap * 1)
   .setRange(1, 4499)
   .setSize(sliderW, sliderH)
   .setValue(4499)
   ;
   */
  cp5.addSlider("resolution")
    .setPosition(guiX, guiY + sliderGap * 2)
    .setRange(1, 10)
    .setValue(3)
    .setSize(sliderW, sliderH)
    .setNumberOfTickMarks(5)
    .setSliderMode(Slider.FLEXIBLE)
    ;
  cp5.addSlider("pointSize")
    .setPosition(guiX, guiY + sliderGap * 3)
    .setRange(1, 5)
    .setValue(1)
    .setSize(sliderW, sliderH)
    .setNumberOfTickMarks(5)
    .setSliderMode(Slider.FLEXIBLE)
    ;
  cp5.addNumberbox("zOffset")
    .setPosition(guiX, guiY + sliderGap * 3)
    .setRange(-300, 300)
    .setValue(0)
    .setSize(sliderW, sliderH)
    ;
  rotation =  cp5.addSlider2D("Rotation")
    .setPosition(10, height - 200 - 30)
    .setSize(200, 200)
    .setMinMax(20, 10, 100, 100)
    .setValue(0, 0)
    .setMinMax(-PI, PI, PI, -PI)
    //.disableCrosshair()
    ;
}


void draw() {
  background(0);

  thresholdMin = int (depthRange.getArrayValue(0));
  thresholdMax = (int) (depthRange.getArrayValue(1));

  // let's make a 3D space!
  // the origin(0,0,0) should be the center of the canvas
  pushMatrix();
  translate(width/2, height/2);
  rotateY(rotation.getArrayValue(0));
  rotateX(rotation.getArrayValue(1));

  noFill();
  stroke(255);
  box(200);

  int[] rawDepth = kinect2.getRawDepth();
  int w = kinect2.depthWidth;
  int h = kinect2.depthHeight;
  depthImg.loadPixels();
  for (int i=0; i < rawDepth.length; i++) {
    int x = i % w;
    int y = floor(i / w);
    int depth = rawDepth[i]; // z

    if ( depth >= thresholdMin
      && depth <= thresholdMax
      && depth != 0) {

      float r = map(depth, thresholdMin, thresholdMax, 255, 0);
      float b = map(depth, thresholdMin, thresholdMax, 0, 255);

      depthImg.pixels[i] = color(r, 0, b);

      if (x % resolution == 0 && y % resolution == 0) { 
        float pX = map(x, 0, w, -w/2, w/2); 
        float pY = map(y, 0, h, -h/2, h/2);
        float pZ = map(depth, 1, 4499, 500, -500);
        strokeWeight(pointSize);
        point(pX, pY, pZ);
      }
    } else {
      depthImg.pixels[i] = color(0, 0);
    }
  }
  depthImg.updatePixels();


  popMatrix();


  image(kinect2.getDepthImage(), 0, 0, kinect2.depthWidth * 0.3, kinect2.depthHeight * 0.3);
  image(depthImg, 0, 0, kinect2.depthWidth * 0.3, kinect2.depthHeight * 0.3);

  fill(255);
  text(frameRate, 10, 20);
}
