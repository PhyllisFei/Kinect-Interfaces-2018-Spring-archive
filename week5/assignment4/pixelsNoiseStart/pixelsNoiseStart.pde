import processing.video.*;

float threshold = 50;

Capture cam;
PImage prevCam;
PImage img;

void setup() {
  size(640, 480);

  cam = new Capture(this, 640, 480);
  cam.start();

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

  for (int i = 0; i < 3000; i++) {
    int x = int (random(img.width));
    int y = int (random(img.height));
    color c = img.get(x, y);

    float dia = random (5, 20);
    fill(red(c), green(c), blue(c), 150);
    ellipse(x, y, dia, dia);
    noStroke();
    //prevCam = cam.copy(); —————————— becomes super slow??
  }
}
void keyPressed() {
  if (key == ' ') {
    prevCam = cam.copy();
  }
}