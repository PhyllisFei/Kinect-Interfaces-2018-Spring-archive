class Ball {
  float x, y, size;
  color clr;
  float xspeed, yspeed;
  boolean isDone;
  boolean isExploded;

  // constructor
  Ball(float tempX, float tempY) {
    x = tempX;
    y = tempY;
    size = random(3, 5);
    xspeed = 0;
    yspeed = -10;
    clr = color(random(255), random(255), random(255));
    isDone = false;
  }
  void display() {
    fill(clr);
    ellipse(x, y, size, size);
  }
  void move() {
    x += xspeed;
    y += yspeed;
    if (isExploded) {
      xspeed*=0.95;
      yspeed*=0.95;
    }
  }
  void gravity(float g) {
    yspeed += g;
  }
  void explode() {
    isExploded = true;
    xspeed = random(-10, 10);
    yspeed = random(-10, 10);
  }
  //void checkOutOfCanvas() {
  //  if (x < 0 || x > width) {
  //    isDone = true;
  //  }
  //  if (y < 0 || y > height) {
  //    isDone = true;
  //  }
  //}
}