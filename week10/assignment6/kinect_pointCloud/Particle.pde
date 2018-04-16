class Particle {
  PVector pos;
  PVector vel;

  color clr;

  int pointSize;

  Particle(float x, float y, float z, color c, int size) {
    pos = new PVector(x, y, z);
    vel = new PVector(0, random(1, 3), 0);
    clr = c;
    pointSize = size; 
  }

  void move() {
    pos.add(vel);
  }

  void display() {
    pushStyle();
    stroke(clr);
    strokeWeight(pointSize);
    point( pos.x, pos.y, pos.z);
    popStyle();
  }
}
