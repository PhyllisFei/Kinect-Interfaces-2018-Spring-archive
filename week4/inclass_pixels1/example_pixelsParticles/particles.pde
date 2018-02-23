class Particle {
  // feel free to use PVector if you are familiar with it!
  float posX, posY;
  float velX, velY;
  float dia;
  color c; // white color
  
  Particle(float x, float y) {
    posX = x;
    posY = y;
    velX = random(-5,-1);
    velY = 0;
    dia = 5;
  }
  
  void update() {
    posX += velX;
    posY += velY;
  }
  
  void checkEdge() {
    if (posX < 0) {
      posX = width;
    }
  }
  
  void updateColor(color _c) {
    c = _c;
    float avg = (red(c) + green(c) + blue(c)) / 3; 
    dia = map(avg, 0, 255, 1, 30); 
  }
  
  void display() {
    pushStyle();
    fill(c);
    ellipse(posX, posY, dia, dia); 
    popStyle();
  }
}