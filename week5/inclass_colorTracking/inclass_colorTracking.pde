import processing.video.*;

Capture cam;
PImage trackingImg;
color trackingColor;
float trackingX;
float trackingY;
float avgX = 0;
float avgY = 0;

int threshold = 25;

void setup() {
  size(640, 480);
  background(0);
  noStroke();

  cam = new Capture(this, width, height);
  cam.start();
  trackingImg = createImage(width, height, ARGB);
}

void draw() {
  if (cam.available()) {
    cam.read();
    cam.loadPixels();
  }

  float sumX = 0;
  float sumY = 0;
  int count = 0;

  int h = cam.height;
  int w = cam.width;
  trackingImg.loadPixels();
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      int index = x+y*w;

      float r = red(cam.pixels[index]);
      float g = green(cam.pixels[index]);
      float b = blue(cam.pixels[index]);

      if ( r > red(trackingColor) - threshold &&  r < red(trackingColor) + threshold
        && g > green(trackingColor) - threshold && g < green(trackingColor) + threshold
        && b > blue(trackingColor) - threshold &&  b < blue(trackingColor) + threshold)
      {
        trackingImg.pixels[index] = color(255, 0, 0);     
        sumX += x;
        sumY += y;
        count++;
      } else {
        trackingImg.pixels[index] = color(0, 0);//w, alpha
      }
    }
  }
  trackingImg.updatePixels();
  image(cam, 0, 0); //x,y
  image(trackingImg, 0, 0);

  if (count > 0) {
    avgX = sumX / count;
    avgY = sumY / count;
  }

  trackingX = lerp(trackingX, avgX, 0.2);
  trackingY = lerp(trackingY, avgY, 0.2);


  // show the picked color
  fill(trackingColor);
  rect(10, 10, 50, 50);
  fill(255);
  text(threshold, 70, 20);

  // show the center position of the tracking area
  noFill();
  stroke(0, 255, 0);
  ellipse(avgX, avgY, 10, 10);
  line(avgX, 0, avgX, height);
  line(0, avgY, width, avgY);

  //show the lerped circle
  noStroke();
  fill(255, 255, 0);
  ellipse(trackingX, trackingY, 10, 10);
}

void mousePressed() {
  trackingColor = cam.get(mouseX, mouseY);
}

void keyPressed() {
  if (keyCode == LEFT) {
    threshold --;
  } else if (keyCode == LEFT) {
    threshold ++;
  }
  threshold = constrain(threshold, 0, 100);
}