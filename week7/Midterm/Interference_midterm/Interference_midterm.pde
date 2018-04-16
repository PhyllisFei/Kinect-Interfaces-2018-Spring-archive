import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
import de.voidplus.leapmotion.*;

OpenCV opencv;
Capture cam;

int scale = 4;

float handX, handY;
float prevHandX, prevHandY;

PImage camImg;
PImage smallerImg;
PImage img;
Rectangle[] faces;
PGraphics pg;
PImage cursor;

boolean isHandDetected = false;
boolean isFaceClose = false;
boolean handR;

ArrayList<Rect> rects = new ArrayList<Rect>();

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

  cursor = loadImage("cursor.png");

  LeapMotion_setup();
}


void draw() {
  isHandDetected = false;
  isFaceClose = false;

  if ( cam.available() ) {
    cam.read();

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
  if (faces != null) {
    for (int i =0; i < faces.length; i++) {

      float faceX  = faces[i].x * scale;
      float faceY  = faces[i].y * scale;

      if (isFaceClose == true 
        && isHandDetected == true 
        && handR == true) {

        /*******************************generate circles************************************/
        if (handX > faceX && handX < faceX + faces[i].width * scale && handY > faceY && handY < faceY + faces[i].height * scale) {
          rects.add( new Rect( lerp(prevHandX, handX, 0.1), lerp(prevHandY, handY, 0.1), random(1, 20), camImg) );
          rects.add( new Rect( lerp(prevHandX, handX, 0.2), lerp(prevHandY, handY, 0.2), random(1, 20), camImg) );
          rects.add( new Rect( lerp(prevHandX, handX, 0.3), lerp(prevHandY, handY, 0.3), random(1, 20), camImg) );
          rects.add( new Rect( lerp(prevHandX, handX, 0.4), lerp(prevHandY, handY, 0.4), random(1, 20), camImg) );
          rects.add( new Rect( lerp(prevHandX, handX, 0.5), lerp(prevHandY, handY, 0.5), random(1, 20), camImg) );
          rects.add( new Rect( lerp(prevHandX, handX, 0.6), lerp(prevHandY, handY, 0.6), random(1, 20), camImg) );
          rects.add( new Rect( lerp(prevHandX, handX, 0.7), lerp(prevHandY, handY, 0.7), random(1, 20), camImg) );
          rects.add( new Rect( lerp(prevHandX, handX, 0.8), lerp(prevHandY, handY, 0.8), random(1, 20), camImg) );
          rects.add( new Rect( lerp(prevHandX, handX, 0.9), lerp(prevHandY, handY, 0.9), random(1, 20), camImg) );
          rects.add( new Rect( handX, handY, random(10, 25), camImg) );

          prevHandX = handX;
          prevHandY = handY;
        }
        /*******************************generate circles************************************/
      }
    }
  }

  // ******* draw on PGraphic *******
  pg.beginDraw();
  pg.clear();

  /*******************************update circles************************************/
  // ******* update & show particles ******* //
  for (int i=0; i<rects.size(); i++) {
    rects.get(i).update();
    rects.get(i).displayIn(pg);
  }

  // ******* remove particles when hand or face is not detected ******* //
  if (isFaceClose == false || isHandDetected == false) {
    for (int i=rects.size()-1; i>=0; i--) {
      if (rects.get(i).alpha <= 3) {
        rects.remove(i);
      }
    }
  }
  /*******************************update circles************************************/

  pg.endDraw();
  image(pg, 0, 0);
}
