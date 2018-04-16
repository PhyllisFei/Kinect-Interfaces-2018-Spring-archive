import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;


OpenCV opencv;
Capture cam;

Rectangle[] faces;
PImage smallerImg;

int scale = 4;
//PVector v1, v2;

void setup() {
  size(640, 480);
  cam = new Capture(this, 640, 480);
  cam.start();

  opencv = new OpenCV(this, cam.width/scale, cam.height/scale);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE); 

  smallerImg = createImage(opencv.width, opencv.height, RGB);
}


void draw() {
  if ( cam.available() ) {
    cam.read();

    smallerImg.copy(cam, 
      0, 0, cam.width, cam.height, 
      0, 0, smallerImg.width, smallerImg.height);
    smallerImg.updatePixels();
  }

  //background(0);
  image(cam, 0, 0);

  // We have to always "load" the  image into OpenCV 
  // But we check against the smallerImg image here
  opencv.loadImage(smallerImg);
  faces = opencv.detect();  

  if (faces == null) {
    return;
  }

  for (int i = 0; i < faces.length; i++) {
    strokeWeight(2);
    stroke(255, 0, 0);
    noFill();

    int faceWidth = faces[i].width*scale;
    int faceHeight = faces[i].height*scale;

    //rect(faces[i].x*scale, faces[i].y*scale, 
      //faceWidth, faceHeight);
    

    
    if(faceWidth > 200){
    int faceCenterX = faces[i].x*scale + faceWidth/2;
    int faceCenterY = faces[i].y*scale + faceHeight/2;

    int maxRadius = max(faceWidth, faceHeight+40) / 2;

    //
    int initX = faceCenterX;
    int initY = faceCenterY;
    
    for (int delta = 0; delta <= 180; ++delta) {
      int deltaX = (int)(maxRadius * sin(delta));
      int y = initY - (int)(maxRadius * cos(delta));
      int smallRadius = 5 * faces[i].width*scale/80;
      //int small2R = 2 * smallRadius;
      for(int j = -deltaX; j <= deltaX;)
      {
         int x = initX + j;
         float dist = dist(x,y,initX,initY);
         float dynamicRadius = smallRadius * (1.5-dist / maxRadius);
         color c = get(x,y);
         noStroke();
         fill(red(c) + random(-15,15), green(c) + random(-15,15),blue(c) + random(-18,18));
         ellipse(x, y, dynamicRadius, dynamicRadius);
          j += dynamicRadius;
      }
    }
      
      /*
      int circleDistance = 15;
      for (int num = 0; num <= abs((x - initX)/5); ++num) {
        if (x >= initX) {
          fill(255, 0, 0);
          ellipse(x - num*circleDistance, y, 10, 10);
        } else {
          ellipse(x + num*circleDistance, y, 10, 10);
        }
      }
      //*/
    }

    /*
    for (int a = 0; a < 3000; a++) {
     
     int x = (int)random(faces[i].x*scale, (faces[i].x+faces[i].width)*scale);
     int y = (int)random(faces[i].y*scale, (faces[i].y+faces[i].height)*scale);
     
     float distance  = dist(x, y, faceCenterX, faceCenterY);
     
     if (distance < maxRadius) {
     fill(255, 255, 0);
     ellipse(x, y, 10, 10);
     }
     }
     */
  }
}
