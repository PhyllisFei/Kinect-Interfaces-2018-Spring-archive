class Particle {
  PVector pos;
  PVector vel;
  color clr;

  Particle(float x, float y, float z, color c) {
    pos = new PVector(x, y, z);
    vel = new PVector(0, random(1, 3), 0);
    clr = c;
  }

  void move() {
    pos.add(vel);
  }

  void display() {
    pushStyle();
    stroke(clr);
    strokeWeight(5);
    point( pos.x, pos.y, pos.z);
    popStyle();
  }
}
