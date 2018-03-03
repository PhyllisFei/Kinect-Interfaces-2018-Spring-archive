import processing.video.*;

float threshold = 50;

Capture cam;
PImage prevCam;
PImage img;

Button btn;

void setup() {
  size(640, 480);

  cam = new Capture(this, 640, 480);
  cam.start();

  prevCam = createImage (cam.width, cam.height, RGB);
  img = createImage (cam.width, cam.height, ARGB);

  btn = new Button(width * 0.8, height/2, 50);
}

void draw() {
  background(0);

  if ( cam.available() ) {
    cam.read();
    cam.loadPixels();
    prevCam.loadPixels();
    img.loadPixels();
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

        //float amp = 5.0;
        //img.pixels[i] = color(diffR*amp, diffG*amp, diffB*amp);
        float diffSum = diffR + diffG + diffB;
        if (diffSum > threshold ) {
          img.pixels[i] = color(255);
          btn.checkDistance(x, y);
        } else {
          img.pixels[i] = color(0, 0);
        }
      }
    }
  }
  img.updatePixels();

  //image(cam, 0, 0);
  image(img, 0, 0);

  btn.updateHitCount();
  btn.display();

  //prevCam = cam.copy();
}

void keyPressed() {
  if (key == ' ') {
    prevCam = cam.copy();
  }

  if (keyCode == LEFT) {
    threshold--;
  } else if (keyCode == RIGHT) {
    threshold++;
  }
  threshold = constrain(threshold, 0, 255);
  println(threshold);
}