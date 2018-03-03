ArrayList<Ball>


Ball[] balls = new Ball[50];

void setup () {
  size(500, 600);
  for (int i=0; i<balls.length; i++) {
    balls[i] = new Ball( random(width), random(height), random(30, 80) ); //constructor
  }
}

void draw () {
  background(100);
  for (int i=0; i<balls.length; i++) {
    //update values
    balls[i].move();
    //check
    balls[i].bounce();
    //display
    balls[i].display();
  }
}

class Ball {
  //fields (variables)
  float x;
  float y;
  float size;
  float xSpeed;
  float ySpeed;
  color c;

  //constructor
  Ball(float tempX, float tempY, float tempSize) {
    x = tempX;
    y = tempY;
    size = tempSize;
    xSpeed = random(-50, 1);
    ySpeed = random(-20, 5);
    c = color( random(255), random(255), random(255) );
  }

  //methods (functions)
  void display() {
    fill (c);
    noStroke();
    ellipse(x, y, size, size);
  }
  void move() {
    x = x+xSpeed;
    y = y+ySpeed;
  }
  void bounce() {
    if (x < 0 || x > width) {
      xSpeed = -xSpeed;
    }
    if (y < 0 || y > height) {
      ySpeed = -ySpeed;
    }
  }
}