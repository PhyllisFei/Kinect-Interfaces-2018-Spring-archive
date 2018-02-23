ArrayList<Ball> balls = new ArrayList<Ball>();


void setup() {
  size(500, 600);
  noStroke();
}


void draw() {
  background(0);

  for (int i=0; i<balls.size(); i++) {
    Ball b = balls.get(i);
    // update
    b.move();
    b.updateLifespan();
    b.bounce();
    
    // ***
    for (int j=0; j<balls.size(); j++) {
      Ball otherBall = balls.get(j);
      if (i != j) {
        b.connectLine( otherBall );
      }
    }
    
    b.display();
  }

  if (mousePressed) {
    balls.add( new Ball(mouseX, mouseY) );
  }
  
  for (int i = balls.size()-1; i >= 0; i--) {
    Ball b = balls.get(i);
    if (b.isDone) {
      balls.remove(i);
    }
  }
  
  // display the number of the balls
  fill(255);
  text(balls.size(), 20, 30);
}