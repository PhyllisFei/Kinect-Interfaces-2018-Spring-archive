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
  // translucent background for the trail effect
  pushStyle();
  fill(0, 15);
  noStroke();
  rect(0, 0, width, height);
  popStyle();

  // if the cam image is updated, load it
  if (cam.available()) {
    cam.read();
    cam.loadPixels();
  }

  // create a ball (fireworks)
  if (mousePressed) {
    if (balls.size() < 500) {
      balls.add( new Ball(width/2, height) );
      balls.add( new Ball(width/2, height) );
      balls.add( new Ball(width/2, height) );
      balls.add( new Ball(width/2, height) );
      balls.add( new Ball(width/2, height) );
      balls.add( new Ball(width/2, height) );
    }
  }

  // ball iteration
  for (int i=0; i<balls.size(); i++) {
    Ball b = balls.get(i);

    // 1: UPDATE values first!
    if (keyPressed) {
      b.explode();
    }
    b.update();
    int colorIndex = floor(b.posX) + floor(b.posY) * cam.width;
    if (colorIndex < cam.pixels.length && colorIndex >= 0) {
      b.updateColor( cam.pixels[colorIndex] );
    }

    // 2: CHECK or compare
    b.checkEdge();

    // 3: DISPLAY then finally display!
    b.display();
  }
}


// event!
void mousePressed() {
  // exectuted only once !!!
}

// environment variables - simply pink ones!!!!!! mouseX, width, frameCount, ... , etc.
// mousePressed --> true or false