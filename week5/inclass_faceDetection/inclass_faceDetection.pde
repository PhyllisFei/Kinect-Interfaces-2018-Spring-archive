import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle; //import java.awt.*;

Capture cam;
OpenCV opencv;

int scale = 4;


void setup() {
  size(640, 480);

  cam = new Capture(this, 640, 480);
  cam.start();

  opencv = new OpenCV(this, cam.width / scale, cam.height / scale);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
}

void draw() {
  if ( cam.available() ) {
    cam.read();

    PImage smallerImg = createImage(cam.width/scale, cam.height/scale, RGB);
    
    smallerImg.copy(
      cam, 
      0, 0, cam.width, cam.height,
      0, 0, cam.width/scale, cam.height/scale
      );
    //smallerImg.updatePixels();
    opencv.loadImage(smallerImg);
  }
  image(cam, 0, 0);

  Rectangle[] faces = opencv.detect();

  for (int i = 0; i < faces.length; i ++) {
    Rectangle face = faces[i];

    strokeWeight(5);
    stroke(255, 0, 0);
    noFill();
    rect(face.x*scale, face.y*scale, face.width * scale, face.height*scale);
  }
}