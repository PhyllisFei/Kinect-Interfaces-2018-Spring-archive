import processing.video.*;

Capture cam;
ArrayList<Ball> balls = new ArrayList<Ball>(); 

void setup() {
  size(640, 480);
  noStroke();

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

  if (mousePressed) {
    if (balls.size() < 500) {
      balls.add( new Ball(width/2, random(height)) );
      balls.add( new Ball(width/2, random(height)) );
      balls.add( new Ball(width/2, random(height)) );
      balls.add( new Ball(width/2, random(height)) );
      balls.add( new Ball(random(width), random(height)) );
    }
  }

  for (int i=0; i<balls.size(); i++) {
    Ball b = balls.get(i);
    if (keyPressed) {
      b.explode();
    }
    b.update();
    int colorIndex = floor(b.posX) + floor(b.posY) * cam.width;
    if (colorIndex < cam.pixels.length && colorIndex >= 0) {
      b.updateColor( cam.pixels[colorIndex] );
    }
    b.checkEdge();
    b.display();
  }
  text(balls.size(), 20, 30);
}