class Circle {
  float x, y;
  float size;
  color c;
  int alpha;
  float speed;
  float directionX, directionY;

  Circle(float _x, float _y, float _size, PImage _cam) {
    x = _x;
    y = _y;
    size = _size;

    // right hand to draw face; left hand to erase
    if (handR == true) {
      c = _cam.get(int(x), int(y));
      alpha = 100;
    } else {
      c = (0);
      alpha = 155;
    }
  }

  void update() {
    alpha -= 0.5;
  }
  void display() {
    pushStyle();
    noStroke();
    fill(red(c), green(c), blue(c), alpha);
    ellipse(x, y, size, size);
    popStyle();
  }
  void displayIn( PGraphics p ) {
    p.pushStyle();
    p.noStroke();
    p.fill(red(c), green(c), blue(c), alpha);
    p.ellipse(x, y, size, size);
    p.popStyle();
  }
}
