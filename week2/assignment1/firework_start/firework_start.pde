ArrayList<Ball> balls = new ArrayList<Ball>();

void setup() {
  size(500, 500);
  noStroke();
}

void draw() {
  background(0);
  if (keyPressed) {
    for (int i=0; i<50; i++) {
      balls.add( new Ball(width/2, height) );
    }
  }
  for (int i=0; i<balls.size(); i++) {
    Ball b = balls.get(i);
    b.move();
    b.gravity(0.1);
    b.display();
  }

  //for (int i = balls.size()-1; i >= 0; i--) {
  //  Ball b = balls.get(i);
  //  if (b.isDone) {
  //    balls.remove(i);
  //  }
  //}

  // display the number of the balls
  fill(255);
  text(balls.size(), 20, 30);
}

void mouseMoved() {
  for (int i=0; i<balls.size(); i++) {
    Ball b = balls.get(i);
    b.explode();
  }
}