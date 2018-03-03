class Ball {
  // feel free to use PVector if you are familiar with it!
  float posX, posY;
  float velX, velY;
  float dia;
  color c;
  boolean isExploded;

  Ball(float x, float y) {
    posX = x;
    posY = y;
    velX = 0;
    velY = -10;
    dia = 5;
    c = color(255);
    isExploded = false;
  }
  void update() {
    posX += velX;
    posY += velY;
  }
  void display() {
    pushStyle();
    fill(c);
    ellipse(posX, posY, dia, dia); 
    popStyle();
  }

  void explode() {
    // should not be looped - executed only once!
    isExploded = true;
    velX = random(-5, 5);
    velY = random(-5, 5);
  }

  void checkEdge() {
    if (posX < 0) {
      posX = width;
    } else if (posX > width) {
      posX = 0;
    }
  }

  void updateColor(color _c) {
    if (isExploded) {
      c = _c;
      float avg = (red(c) + green(c) + blue(c)) / 3; 
      dia = map(avg, 0, 255, 1, 20);
    }
  }
}