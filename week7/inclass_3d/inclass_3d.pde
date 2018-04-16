ArrayList<Particle> particles = new ArrayList <Particle> ();


void setup() {
  size(500, 600, P3D);
}

void draw() {
  background(0);

  // navi
  float rotX = map(mouseY, 0, height, -45, 45);
  float rotY = map(mouseX, 0, width, -90, 90);
  translate(width/2, height/2);
  rotateX(radians(rotX));
  rotateY(radians(rotY));

  // do sth here

  particles.add( new Particle() );

  for (int i=0; i<particles.size(); i++) {
    Particle p = particles.get(i);
    p.move();
    p.display();
  }

  //noFill();
  //stroke(255);
  //box(200); // box(w,h,depth);
}


class Particle {
  PVector pos;
  PVector vel; // vel.x, vel.y, vel.z

  Particle() {
    pos = new PVector();
    vel = new PVector();
    vel.x = random(-2, 2);
    vel.y = random(-2, 2);
    vel.z = random(-2, 2);
  }

  void move() {
    pos.add(vel);
  }

  void display() {
    pushStyle();
    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    stroke(255);
    fill(255, 100);
    box(5);
    //sphereDetail(10);
    //sphere(100);

    popMatrix();
    popStyle();
  }
}