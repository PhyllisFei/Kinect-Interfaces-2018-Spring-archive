class Circle {
  PVector pos;
  PVector vel;
  float dia;
  color clr;
  String name;
  float lifespan;
  boolean isDone;

  Circle(float x, float y, float d, int r, int g, int b, String n) {
    pos = new PVector(x, y);
    vel = new PVector(random(-1, 1), random(-1, 1));
    dia = d;
    clr = color(r,g,b);
    name = n;
    lifespan = 1.0;
    isDone = false;
  }
  
  void update() {
    pos.add(vel);
    lifespan -= 0.005;
    if (lifespan <= 0) {
      isDone = true;
    }
  }
  
  void display() {
    fill(clr);
    ellipse(pos.x, pos.y, dia, dia);
    fill(255);
    text(name, pos.x, pos.y);
  }
}
