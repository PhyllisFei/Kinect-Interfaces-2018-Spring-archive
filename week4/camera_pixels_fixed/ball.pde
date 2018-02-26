class Ball {
  float posX, posY;
  float velX, velY;
  float dia;
  //float freq = random(2.0,5.0);
  //float amp = random(2,5);
  color c;
  boolean isExploded;

  Ball(float x, float y) {
    posX = x;
    posY = y;
    velX = random(-1, 1); //0;
    velY = random(-1, 1  ); //-10
    dia = 5;
    c = color(255);
    isExploded = false;
  }
  void update() {
    //float velX = noise(frameCount*freq+posX)*amp;
    //float velY = noise( frameCount*freq+posY )*amp;
    //float valueX = noise(velX)*amp;
    //float valueY = noise(velY)*amp;

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
    isExploded = true;
    velX = random(-1,1);
    velY = random(-1,1);
  }

  void checkEdge() {
    if (posX < width/4) {
      posX = width*3/4;
    } else if (posX > width*3/4) {
      posX = width/4;
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