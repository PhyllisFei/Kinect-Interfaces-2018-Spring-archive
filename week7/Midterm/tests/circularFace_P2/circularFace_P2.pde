import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
import de.voidplus.leapmotion.*;

OpenCV opencv;
Capture cam;

int scale = 4;

boolean handR;
float handX, handY;
float phandX, phandY;

PGraphics pg;
PImage camImg;
PImage smallerImg;
PImage prevCam, img;
Rectangle[] faces;


ArrayList<Circle> circles = new ArrayList<Circle>();

void setup() {
  size(640, 480);
  noStroke();

  cam = new Capture(this, 640, 480);
  cam.start();

  opencv = new OpenCV(this, cam.width/scale, cam.height/scale);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 

  smallerImg = createImage(opencv.width, opencv.height, RGB);
  prevCam = createImage (cam.width, cam.height, RGB);

  pg = createGraphics(cam.width, cam.height);

  LeapMotion_setup();
}


void draw() {
  background(0);

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

  if (faces == null) {
    return;
  }


  // add color difference effect to entire webcam
  int h = cam.height;
  int w = cam.width;

  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      int I = x + y*w;

      float currR = red(cam.pixels[I]);
      float currG = green(cam.pixels[I]);
      float currB = blue(cam.pixels[I]);

      float prevR = red(prevCam.pixels[I]);
      float prevG = green(prevCam.pixels[I]);
      float prevB = blue(prevCam.pixels[I]);

      float diffR = abs(prevR - currR);
      float diffG = abs(prevG - currG);
      float diffB = abs(prevB - currB);

      float diffSum = diffR + diffG + diffB;

      if (diffSum > 200 ) {
        prevCam.pixels[I] = color(diffR, diffG, diffB);

        prevCam.updatePixels();
      } else {
        //img.pixels[I] = color(0);
      }
    }
  }
  prevCam = cam.copy();
  image(cam, 0, 0);


  // ******* detect face & draw ellipse
  for (int i = 0; i < faces.length; i++) {
    
    int faceWidth = faces[i].width*scale;
    int faceHeight = faces[i].height*scale;

    if (faceWidth > 200) {
      // ******* pixelated "face"
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
      //prevCam = cam.copy();
    }
  }

  LeapMotion_run();

  // ******* draw portrait
  if (handR == true) {
    circles.add( new Circle( handX, handY, random(5), camImg) );
    circles.add( new Circle( handX, handY, random(5), camImg) );
  }
  // ******* erase portrait ????????
  if (handR == false) {
    circles.add( new Circle( handX, handY, random(30), camImg) );
    circles.add( new Circle( handX, handY, random(30), camImg) );
  }

  // ******* draw/erase on PGraphic
  pg.beginDraw();
  // update & draw circles
  for (int i=0; i<circles.size(); i++) {
    circles.get(i).update();
    circles.get(i).displayIn( pg );
  }
  pg.endDraw();

  for (int i=circles.size()-1; i>=0; i--) {
    if (circles.get(i).alpha <= 0) {
      circles.remove(i);
    }
  }

  image(pg, 0, 0);

  //if (faces == null) {
  //  return;
  //}
}
