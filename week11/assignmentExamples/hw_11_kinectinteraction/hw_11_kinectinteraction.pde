import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import controlP5.*;
import gab.opencv.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioPlayer gun;
AudioOutput out;
Oscil       wave;

ControlP5 cp5;
OpenCV opencv;

Kinect2 kinect2;
PImage depthImg;

int thresholdMin = 0;
int thresholdMax = 4499;


PVector maxpos = new PVector();
PVector pos = new PVector();


void setup() {
  size(512, 424, P2D);

  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  minim = new Minim(this);
  gun = minim.loadFile("gunshot.wav");

  out = minim.getLineOut();
  wave = new Oscil( 440, 0.5f, Waves.SINE );
  wave.patch( out );

  depthImg = new PImage(kinect2.depthWidth, kinect2.depthHeight, ARGB);
  opencv = new OpenCV(this, depthImg);

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

      int x = i % kinect2.depthWidth;
      int y = floor(i / kinect2.depthWidth);

      float w = map(depth, thresholdMin, thresholdMax, 255, 1);
      //float b = map(depth, thresholdMin, thresholdMax, 0, 255);

      depthImg.pixels[i] = color(w);
    } else {
      depthImg.pixels[i] = color(0, 0);
    }
  }
  depthImg.updatePixels();

  image(kinect2.getDepthImage(), 0, 0);
  //image(depthImg, 0, 0);


  opencv.loadImage(depthImg);
  opencv.gray();
  opencv.dilate();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.dilate();

  maxpos = opencv.max();

  image(opencv.getOutput(), 0, 0);

  float amp = map( maxpos.y, 0, height, 1, 0 );
  wave.setAmplitude( amp );

  float freq = map( maxpos.x, 0, width, 110, 880 );
  wave.setFrequency( freq );

  stroke(0, 255, 0);
  noFill();
  line(maxpos.x, 0, maxpos.x, height);
  line(0, maxpos.y, width, maxpos.y);


  //rect(maxpos.x-10, maxpos.y, 20, 10);
  //rect(maxpos.x-10, maxpos.y-20, 50, 20);


  if (maxpos.x!=0 && maxpos.x>100 && maxpos.x<400 && maxpos.y<300) {
    fill(255, 0, 0);
    noStroke();
    rect(maxpos.x-10, maxpos.y, 20, 10);
    rect(maxpos.x-10, maxpos.y-20, 50, 20);
    if (maxpos.x < width/2+10 && maxpos.x > width/2-10 && maxpos.y<height/2+10 && maxpos.y > height/2-10 ) {
      if (!gun.isPlaying()) {
        gun.rewind();
        gun.play();
      }
    }
  } else {
    ellipse(maxpos.x, maxpos.y, 40, 40);
  }

  fill(255);
  text(frameRate, 10, 20);
}