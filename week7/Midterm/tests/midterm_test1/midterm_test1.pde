import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
import de.voidplus.leapmotion.*;

OpenCV opencv;
Capture cam;

int scale = 4;

float handX, handY;
float indexX, indexY;
float prevIndexX, prevIndexY;

float _handX, _handY;
float phandX, phandY;

float distance;
float sw;
color c;

PImage camImg;
PImage smallerImg;
PImage img;
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

  // ******* detect face position ******* //
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

  // ******* use right hand to draw(generate) particles ******* //
  
  if (isFaceClose == true 
    && isHandDetected == true 
    && handR == true ) {

      
    /*******************************draw circles************************************/
    //circles.add( new Circle( handX, handY, random(5, 25), camImg) );
    //circles.add( new Circle( handX, handY, random(5, 25), camImg) );
    //circles.add( new Circle( handX, handY, random(5, 25), camImg) );
    //circles.add( new Circle( handX, handY, random(5, 25), camImg) );
    //circles.add( new Circle( handX, handY, random(5, 25), camImg) );
    //circles.add( new Circle( handX, handY, random(5, 25), camImg) );

    circles.add( new Circle( lerp(prevIndexX, indexX, 0.1), lerp(prevIndexY, indexY, 0.1), random(10, 25), camImg) );
    circles.add( new Circle( lerp(prevIndexX, indexX, 0.2), lerp(prevIndexY, indexY, 0.2), random(10, 25), camImg) );
    circles.add( new Circle( lerp(prevIndexX, indexX, 0.3), lerp(prevIndexY, indexY, 0.3), random(10, 25), camImg) );
    circles.add( new Circle( lerp(prevIndexX, indexX, 0.4), lerp(prevIndexY, indexY, 0.4), random(10, 25), camImg) );
    circles.add( new Circle( lerp(prevIndexX, indexX, 0.5), lerp(prevIndexY, indexY, 0.5), random(10, 25), camImg) );
    circles.add( new Circle( lerp(prevIndexX, indexX, 0.6), lerp(prevIndexY, indexY, 0.6), random(10, 25), camImg) );
    circles.add( new Circle( lerp(prevIndexX, indexX, 0.7), lerp(prevIndexY, indexY, 0.7), random(10, 25), camImg) );
    circles.add( new Circle( lerp(prevIndexX, indexX, 0.8), lerp(prevIndexY, indexY, 0.8), random(10, 25), camImg) );
    circles.add( new Circle( lerp(prevIndexX, indexX, 0.9), lerp(prevIndexY, indexY, 0.9), random(10, 25), camImg) );
    circles.add( new Circle( indexX, indexY, random(10, 25), camImg) );

    prevIndexX = indexX;
    prevIndexY = indexY;
    /*******************************draw circles************************************/
  } 

  // ******* draw on PGraphic *******
  pg.beginDraw();
  pg.clear();

  /*******************************draw circles************************************/
  // ******* update & show particles ******* //
  for (int i=0; i<circles.size(); i++) {
    circles.get(i).update();
    circles.get(i).displayIn(pg);
  }

  // ******* remove particles when hand is not detected ******* //
  if (isFaceClose == false || isHandDetected == false) {
    for (int i=circles.size()-1; i>=0; i--) {
      if (circles.get(i).alpha <= 3) {
        circles.remove(i);
      }
    }
  }
  /*******************************draw circles************************************/
  
  pg.endDraw();
  image(pg, 0, 0);
}




















  /*************************************************/
  // ******* add inverse color effect to img *******
  //int h = cam.height;
  //  int w = cam.width;
  //  for (int y = 0; y < h; y++) {
  //    for (int x = 0; x < w; x++) {
  //      int i = x + y*w;

  //      float currR = red(cam.pixels[i]);
  //      float currG = green(cam.pixels[i]);
  //      float currB = blue(cam.pixels[i]);

  //      float prevR = red(camImg.pixels[i]);
  //      float prevG = green(camImg.pixels[i]);
  //      float prevB = blue(camImg.pixels[i]);

  //      float diffR = abs(prevR - currR);
  //      float diffG = abs(prevG - currG);
  //      float diffB = abs(prevB - currB);

  //      float diffSum = diffR + diffG + diffB;

  //      if (diffSum > 200 ) {
  //        img.pixels[i] = color(diffR, diffG, diffB);
  //      } else {
  //        img.pixels[i] = color(0);
  //      }
  //    }
  //  }
  //  img = cam.copy();
  /******************************************************/
