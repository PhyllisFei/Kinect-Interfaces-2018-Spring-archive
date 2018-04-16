class Rect {
  float x, y;
  float size;
  color c;
  int alpha;

  Rect(float _x, float _y, float _size, PImage _cam) {
    x = _x;
    y = _y;
    size = _size;

    // right hand to draw face
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
    rect(x, y, size, size);
    popStyle();
  }
  
  void displayIn( PGraphics p ) {
    p.pushStyle();
    p.noStroke();
    p.fill( red(c), green(c), blue(c), alpha+40 );
    p.rect(x, y, size, size);
    p.popStyle();
  }
}
