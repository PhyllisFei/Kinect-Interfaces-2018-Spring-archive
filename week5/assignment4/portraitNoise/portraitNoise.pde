import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Capture cam;
OpenCV opencv;

int scale = 4;
int gridSize = 1;
int x, y;
int h, w;
float R, G, B;
int faceX, faceY, faceWidth, faceHeight;

void setup() {
  size(640, 480);
  noStroke();
  ellipseMode(CORNER);

  cam = new Capture(this, 640, 480);
  cam.start();
  h = cam.height;
  w = cam.width;
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

    opencv.loadImage(smallerImg);
    //cam.loadPixels();
  }
  image(cam, 0, 0);

  // pixelized face
  for (int y = 0; y < h; y+=gridSize) {
    for (int x = 0; x < w; x+=gridSize) {
      int i =  x + y*w;
      R = red(cam.pixels[i]);
      G = green(cam.pixels[i]);
      B = blue(cam.pixels[i]);
    }
  }

  //face detection
  Rectangle[] faces = opencv.detect();

  for (int i = 0; i < faces.length; i ++) {
    Rectangle face = faces[i];
    rect(face.x*scale, face.y*scale, face.width * scale, face.height*scale);
    faceX = face.x*scale;
    faceY = face.y*scale;
    faceWidth = face.width*scale;
    faceHeight = face.height*scale;

    strokeWeight(3);
    stroke(255, 0, 0);
    noFill();
    //println(faceWidth);
  }

  int threshold = 200;
  if (  faceWidth > threshold) {
    cam.loadPixels();
    fill(R, G, B);
    ellipse(x, y, gridSize, gridSize);
    //map(opencv, 0, 255, 0, );
  } else {
    //
  }
}