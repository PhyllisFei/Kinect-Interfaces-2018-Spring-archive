import processing.video.*;

Capture cam;
ArrayList<Ball> balls = new ArrayList<Ball>(); 

void setup() {
  size(640, 480);
  noStroke();
  ellipseMode(CORNER);

  cam = new Capture(this, width, height);
  cam.start();
}

void draw() {
  pushStyle();
  fill(0, 15);
  noStroke();
  rect(0, 0, width, height);
  popStyle();

  if (cam.available()) {
    cam.read();
    cam.loadPixels();
  }

  if (keyPressed) {
    if (balls.size() < 500) {
      balls.add( new Ball(width/2, height) );
    }
  }
  if (mousePressed) {
    for (int i=0; i<balls.size(); i++) {
      Ball b = balls.get(i);
      b.explode();
      b.checkEdge();

      int colorIndex = floor(b.posX) + floor(b.posY) * cam.width;
      if (colorIndex < cam.pixels.length) {
        b.updateColor( cam.pixels[colorIndex] );
      }

      b.display();
    }
  }
}