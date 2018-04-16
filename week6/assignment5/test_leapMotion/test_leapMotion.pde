float fingerX, fingerY;
ArrayList<Circle> circles = new ArrayList<Circle>();


void setup() {
  size(800, 500);
  background(0);
  noStroke();
  
  LeapMotion_setup();
}


void draw() {
  background(0);

  LeapMotion_run();

  // add circles
  circles.add( new Circle( fingerX, fingerY, random(10)) );

  // update & draw circles
  for (int i=0; i<circles.size(); i++) {
    circles.get(i).update();
    circles.get(i).display();
  }
  // limit the number of circle and remove the oldest circles
  if (circles.size() > 200) {
    circles.remove(0);
  }

  text(circles.size(), 10, 20);
}


class Circle {
  float x, y;
  float size;
  color clr;
  int alpha;
  float speed;
  float directionX, directionY;

  Circle(float _x, float _y, float _size) {
    x = _x;
    y = _y;
    size = _size;
    clr = color(255);
    alpha = 255;
    directionX = random(-1, 1);
    directionY = random(-1, 1);
    speed = 0.1;
  }

  void update() {
    x = x + directionX*speed;
    y = y + directionY*speed;
    alpha -= 3;
    //speed += 0.05;
    speed *= 1.05;
  }
  void display() {
    pushStyle();
    fill(clr, alpha);
    ellipse(x, y, size, size);
    popStyle();
  }
}