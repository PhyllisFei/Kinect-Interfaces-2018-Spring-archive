import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;

Capture cam;
OpenCV opencv;

PImage prevCam;
PImage img;
float threshold = 150;
int scale = 4;
int faceX, faceY, faceWidth, faceHeight;

void setup() {
  size(640, 480);

  cam = new Capture(this, 640, 480);
  cam.start();

  opencv = new OpenCV(this, cam.width / scale, cam.height / scale);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

  prevCam = createImage (cam.width, cam.height, RGB);
  img = createImage (cam.width, cam.height, ARGB);
}

void draw() {
  background(0);

  if ( cam.available() ) {
    cam.read();
    cam.loadPixels();
    prevCam.loadPixels();
    img.loadPixels();

    PImage smallerImg = createImage(cam.width/scale, cam.height/scale, RGB); 
    smallerImg.copy(
      cam, 
      0, 0, cam.width, cam.height, 
      0, 0, cam.width/scale, cam.height/scale
      );
    opencv.loadImage(smallerImg);

    //**** updating portrait pixels
    int h = cam.height;
    int w = cam.width;
    for (int y = 0; y < h; y++) {
      for (int x = 0; x < w; x++) {
        int i = x + y*w;

        float currR = red(cam.pixels[i]);
        float currG = green(cam.pixels[i]);
        float currB = blue(cam.pixels[i]);

        float prevR = red(prevCam.pixels[i]);
        float prevG = green(prevCam.pixels[i]);
        float prevB = blue(prevCam.pixels[i]);

        float diffR = abs(prevR - currR);
        float diffG = abs(prevG - currG);
        float diffB = abs(prevB - currB);

        float diffSum = diffR + diffG + diffB;

        if (diffSum > threshold ) {
          img.pixels[i] = color(diffR, diffG, diffB);
        } else {
          img.pixels[i] = color(0);
        }
      }
    }
  }
  img.updatePixels();
  image(img, 0, 0);


  //**** face (body shape??) detection
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
  }

  if (faceWidth > threshold) {
    //**** add noise (ellipse/rectangle ) effect to pixels, but not really satisfying... 
    for (int i = 0; i < 3000; i++) {
      int x = int (random(img.width));
      int y = int (random(img.height));
      color c = img.get(x, y);

      float dia = random (5, 15);
      fill(red(c), green(c), blue(c), 150);
      ellipse(x, y, dia, dia);
      //rect( random(0,width), random(0,width),random(height,0), random(height,0) );
      noStroke();
      //prevCam = cam.copy();  // ——————————>>> becomes super slow??
    }
  }
}  
void keyPressed() {
  if (key == ' ') {
    prevCam = cam.copy();
  }
}