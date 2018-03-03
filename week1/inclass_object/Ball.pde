class Ball {
  //variables (fields)
  float x, y, size;
  float speedX, speedY;
  color clr;
  boolean isDone;

  //constructor
  Ball(float _x, float _y) {
    x = _x;
    y = _y;
    speedX = random(-2, 2);
    speedY = random(-2, 2);
    size = random(20, 50);
    clr = color(random(255), random(255), random(255));
    isDone = false;
  }

  //functions (methods)
  void move() {
    x += speedY;
    y -= speedX;
  }
  void checkEdges() {
    if (x<0 || x > width) {
      isDone = true;
    }
    if (y<0 || y > width) {
      isDone = true;
    }
  }


  void display() {
    pushStyle();

    noStroke();
    fill(clr);
    ellipse(x, y, size, size);

    popStyle();
  }
}