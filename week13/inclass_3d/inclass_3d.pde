int WORLD_SIZE = 800;

ArrayList<Particle> particles = new ArrayList<Particle>();

void setup() {
  size(600, 600, P3D);

  for (int  i=0; i<500; i++) {
    particles.add(
      new Particle( random(-WORLD_SIZE/2, WORLD_SIZE/2), random(-WORLD_SIZE/2, WORLD_SIZE/2), 0 )
      );
  }
}

void draw() {
  background(0);

  float rotY = map(mouseX, 0, width, -PI, PI);
  float rotX = map(mouseY, 0, height, -PI, PI);

  translate(width/2, height/2);
  //rotateY(rotY);
  //rotateX(rotX);

  stroke(255, 50);
  noFill();
  box(WORLD_SIZE); //w,h,d

  for (int i=0; i<particles.size(); i++) {
    Particle p = particles.get(i);

    for (int j=0; j<particles.size(); j++) {
      if ( i != j ) {
        Particle other = particles.get(j);
        p.repel(other.pos);
      }
    }


    p.attractedTo(new PVector (mouseX-width/2, mouseY-height/2) );

    //PVector gravity = new PVector(0, 1, 0);
    //p.applyForce(gravity);

    p.applyRestitution(-0.02);
    p.update();

    p.chenckEdges();

    p.display();
  }
}
