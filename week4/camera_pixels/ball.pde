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
    velY = 10;
    dia = 5;
    isExploded = false;
  }

  void explode() {
    isExploded = true;  
    posX += velX;
    posY += velY;
  }

  void checkEdge() {
    if (isExploded) {
      if (posX < 0) {
        posX = width;
      }
    }
  }
  void updateColor(color _c) {
    if (isExploded) {
      c = _c;
      float avg = (red(c) + green(c) + blue(c)) / 3; 
      dia = map(avg, 0, 255, 1, 30);
    }
  }
  void display() {
    if (isExploded) {
      pushStyle();
      fill(c);
      ellipse(posX, posY, dia, dia); 
      popStyle();
    }
  }
}