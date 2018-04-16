class Circle {
  float x, y;
  float size;
  color c;
  int alpha;

  Circle(float _x, float _y, float _size, PImage _cam) {
    x = _x;
    y = _y;
    size = _size;

    // right hand to draw face; left hand to erase
    if (handR == true) {
      c = _cam.get(int(x), int(y));
      alpha = 110;
    } else {
      c = (0);
      alpha = 155;
    }
  }

  void update() {
    alpha -= 0.1;
  }
  
  void display() {
    pushStyle();
    noStroke();
    fill( red(c), green(c), blue(c), alpha+40 );
    ellipse(x, y, size, size);
    popStyle();
  }
  
  void displayIn( PGraphics p ) {
    p.pushStyle();
    //p.blendMode(REPLACE);
    p.noStroke();
    p.fill( red(c), green(c), blue(c), alpha+40 );
    p.ellipse(x, y, size, size);
    p.popStyle();
  }
}
