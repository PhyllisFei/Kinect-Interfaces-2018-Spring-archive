class Bug {
  PVector pos, vel, acc;
  Bug() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void move() {
    vel.add(acc);
    vel.limit(3);
    pos.add(vel);
  }

  void display() {
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, 40, 40);
  }

  void fly() {
    if (mousePressed) {
      acc = PVector.random2D();
      pos.x = mouseX;
      pos.y = mouseY;
    } else {
      acc.set(0, 0);
      vel.set(0, 0);
    }
  }
}