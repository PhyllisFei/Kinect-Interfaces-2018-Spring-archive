class Particle {
  // variables (fields, properties)
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  float rad;
  PVector angle;
  PVector rotSpeed;

  // constructors
  Particle(float x, float y, float z) {
    pos = new PVector(x, y, z);
    vel = new PVector();
    acc = new PVector();
    mass = random(1, 10);
    rad = 1 * mass;

    angle = new PVector();
    rotSpeed = new PVector( random(-0.1, 0.1), random(-0.1, 0.1), random(-0.1, 0.1) );
  }

  // functions( methods )
  void update() {
    // position
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);

    // angle
    angle.add(rotSpeed);
  }

  void applyForce( PVector force ) {
    PVector f = force.copy();
    f.div(mass);
    acc.add(f);
  }

  void attractedTo( PVector target) {
    PVector vector = PVector.sub(target, pos);
    float distance = vector.mag();

    if (distance > 100 ) {
      // pull the articles to the center
      vector.mult(0.005);
      applyForce(vector);
    } else {
      // push back
      vector.mult(-0.02);
      applyForce(vector);
    }
  }

  void repel( PVector target) {
    PVector vector = PVector.sub(target, pos);
    float distance = vector.mag();
    if (distance < 10) {
      vector.mult(-0.01);
      applyForce(vector);
    }
  }

  void applyRestitution(float amount) {
    float value = 1.0 + amount;
    vel.mult(value);
  }

  void chenckEdges() {
    // x
    if (pos.x < -WORLD_SIZE/2) {
      pos.x = -WORLD_SIZE/2;
      vel.x *= -1;
    } else if (pos.x > WORLD_SIZE/2) {
      pos.x = -WORLD_SIZE/2;
      vel.x *= -1;
    }

    // y
    if (pos.y < -WORLD_SIZE/2) {
      pos.y = -WORLD_SIZE/2;
      vel.y *= -1;
    } else if (pos.y > WORLD_SIZE/2) {
      pos.y = -WORLD_SIZE/2;
      vel.y *= -1;
    }

    // z
    if (pos.z < -WORLD_SIZE/2) {
      pos.z = -WORLD_SIZE/2;
      vel.z *= -1;
    } else if (pos.z > WORLD_SIZE/2) {
      pos.z = -WORLD_SIZE/2;
      vel.z *= -1;
    }
  }

  void display() {
    pushMatrix();
    pushStyle();

    translate(pos.x, pos.y, pos.z);
    rotateX( angle.x );
    rotateY( angle.y );
    rotateZ( angle.z );

    noFill();
    stroke(255);

    //sphereDetail(10);
    box(rad);

    popStyle();
    popMatrix();
  }
}
