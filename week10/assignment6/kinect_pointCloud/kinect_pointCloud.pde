import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import controlP5.*;

ControlP5 cp5;
Slider2D rotation;
Range depthRange;

Kinect2 kinect2;
int kWidth, kHeight;
PImage depthImg;

int thresholdMin = 0;
int thresholdMax = 4499;
int resolution = 5;
int pointSize;

ArrayList <Particle> particles = new ArrayList <Particle>();

// GUI
int guiX = 10;
int guiY = 150;
int sliderW = 100;
int sliderH = 20;
int sliderGap = sliderH + 10;

void setup() {
  size(1000, 600, P3D);

  kinect2 = new Kinect2(this);

  kinect2.initDepth();
  kinect2.initRegistered();
  kinect2.initDevice();

  kWidth =  kinect2.depthWidth;
  kHeight =  kinect2.depthHeight;

  depthImg = createImage(kWidth, kHeight, ARGB);

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
  cp5.addSlider("resolution")
    .setPosition(guiX, guiY + sliderGap * 1)
    .setRange(1, 10)
    .setValue(3)
    .setSize(sliderW, sliderH)
    .setNumberOfTickMarks(5)
    .setSliderMode(Slider.FLEXIBLE)
    ;
  cp5.addSlider("pointSize")
    .setPosition(guiX, guiY + sliderGap * 2)
    .setRange(1, 30)
    .setValue(20)
    .setSize(sliderW, sliderH)
    .setNumberOfTickMarks(10)
    ;
}

void draw() {
  background(0);

  thresholdMin = int (depthRange.getArrayValue(0));
  thresholdMax = int (depthRange.getArrayValue(1));

  // 3D Space
  pushMatrix();
  translate(width/2, height/2);

  PImage colorImg = kinect2.getRegisteredImage().copy();
  colorImg.loadPixels();
  depthImg.loadPixels();

  int[] rawDepth = kinect2.getRawDepth();

  // 2 forloops: x&y
  for (int i = 0; i < rawDepth.length; i ++) {
    int x = i % kWidth;
    int y = floor (i / kWidth);
    int depth = rawDepth[i]; // z value

    // manipulate the pixels
    if (depth >= thresholdMin
      && depth <= thresholdMax
      && depth != 0) {
      float r = map(depth, thresholdMin, thresholdMax, 255, 0);
      float b = map(depth, thresholdMin, thresholdMax, 0, 255);

      depthImg.pixels[i] = color(r, 0, b);

      if ( x % resolution == 0 && y % resolution == 0) {
        float px = map(x, 0, kWidth, -kWidth/2, kWidth/2);
        float py = map(y, 0, kHeight, -kHeight/2, kHeight/2);
        float pz = map(depth, 1, 4499, 500, -500);

        color c = colorImg.pixels[i];

        point(px, py, pz);

        particles.add( new Particle( px, py, pz, c, pointSize) );
      }
    } else {
      depthImg.pixels[i] = color(0, 0);
    }
  }
  depthImg.updatePixels();

  for (int i = 0; i < particles.size(); i ++) {
    Particle p = particles.get(i);
    p.move();
    p.display();
  }

  while (particles.size() > 1000) {
    particles.remove( 0 );
  }

  popMatrix();

  // 2D Canvas
  image(kinect2.getDepthImage(), 0, 0, kWidth * 0.3, kHeight * 0.3);
  image(depthImg, 0, 0, kWidth * 0.3, kHeight * 0.3);

  fill(255);
  text(frameRate, 10, 20);
  
  //saveFrame("data/frame" + frameCount + ".png");
}
