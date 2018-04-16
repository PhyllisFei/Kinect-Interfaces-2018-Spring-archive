import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
import de.voidplus.leapmotion.*;

OpenCV opencv;
Capture cam;

int scale = 4;

float handX, handY;
float phandX, phandY;

PImage camImg;
PImage smallerImg;
Rectangle[] faces;
PGraphics pg;

boolean isHandDetected = false;
boolean isFaceClose = false;
boolean handR;


ArrayList<Circle> circles = new ArrayList<Circle>();

void setup() {
  size(640, 480);
  noStroke();

  cam = new Capture(this, 640, 480);
  cam.start();

  opencv = new OpenCV(this, cam.width/scale, cam.height/scale);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 

  smallerImg = createImage(opencv.width, opencv.height, RGB);
  camImg = createImage(cam.width, cam.height, ARGB);
  pg = createGraphics(cam.width, cam.height);

  LeapMotion_setup();
}


void draw() {
  //background(0);

  isHandDetected = false;
  isFaceClose = false;

  if ( cam.available() ) {
    cam.read();
    //cam.updatePixels();

    camImg = cam.copy();

    smallerImg.copy(cam, 
      0, 0, cam.width, cam.height, 
      0, 0, smallerImg.width, smallerImg.height);
    smallerImg.updatePixels();
  }

  opencv.loadImage(smallerImg);
  faces = opencv.detect();  

  image(cam, 0, 0);

  if (faces == null) {
    return;
  }

  // ******* detect face position *******
  for (int i = 0; i < faces.length; i++) {  

    int faceWidth = faces[i].width*scale;
    int faceHeight = faces[i].height*scale;

    // ******* face becomes pixelated *******
    if (faceWidth > 200) {

      isFaceClose = true;

      int faceCenterX = faces[i].x*scale + faceWidth/2;
      int faceCenterY = faces[i].y*scale + faceHeight/2;

      int initX = faceCenterX;
      int initY = faceCenterY;

      int maxRadius = max(faceWidth, faceHeight+40) / 2;

      for (int delta = 0; delta <= 180; ++delta) {
        int deltaX = (int)(maxRadius * sin(delta));
        int y_ = initY - (int)(maxRadius * cos(delta));
        int smallRadius = 5 * faces[i].width*scale/80;

        for (int j = -deltaX; j <= deltaX; ) {
          int x_ = initX + j;
          float dist = dist(x_, y_, initX, initY);
          float dynamicRadius = smallRadius * (1.5-dist / maxRadius);
          color c = get(x_, y_);
          noStroke();
          fill(red(c) + random(-15, 15), green(c) + random(-15, 15), blue(c) + random(-18, 18));
          ellipse(x_ + random(-5, 5), y_ + random(-5, 5), dynamicRadius*(0.2), dynamicRadius*2);
          j += dynamicRadius;
        }
      }
    }
  }

  LeapMotion_run();

  // ******* use right hand to draw(generate) particles *******
  if (isFaceClose == true 
    && isHandDetected == true 
    && handR == true) {

    //println(isFaceClose + "  " + isHandDetected + " " + handR);

    circles.add( new Circle( handX, handY, 20, camImg) );
    circles.add( new Circle( handX, handY, 20, camImg) );
  } 

  // ******* draw on PGraphic *******
  pg.beginDraw();
  // ******* update & show particles *******
  for (int i=0; i<circles.size(); i++) {
    circles.get(i).update();
    circles.get(i).displayIn(pg);
  }
  pg.endDraw();

  // ******* remove particles when hand is not detected *******
  if (isHandDetected == false) {
    for (int i=circles.size()-1; i>=0; i--) {
      if (circles.get(i).alpha <= 30) {
        circles.remove(i);
      }
    }
  }
  image(pg, 0, 0);
}
