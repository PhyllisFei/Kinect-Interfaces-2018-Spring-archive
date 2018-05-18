int WATER_HEIGHT = 150;

ArrayList<Ball> balls = new ArrayList<Ball>();

void setup() {
  size(500, 600);
  for (int i=0; i<5; i++) {
    balls.add( new Ball( random(width), random(height) ) );
  }
}

void draw() {
  background(0);

  // balls
  for (int i = 0; i<balls.size(); i++) {
    Ball b = balls.get(i);

    // update
    PVector gravity = new PVector(0, 1);
    gravity.mult(b.mass);
    b.applyForce(gravity);

    //PVector wind = new PVector(-0.5, 1);
    //b.applyForce(wind);
    b.update();

    // check or compare
    //if (b.pos.y < height-WATER_HEIGHT) {
    //  // in the air
    b.applyRestitution(-0.045);
    //} else {
    //  // in the water
    //  b.applyRestitution(-0.30);
    //}
    b.checkEdges();

    // display
    for (int j =0; j<balls.size(); j++) {
      if (i != j) {
        //Ball other = balls.get(j);
        stroke(255);
        //line(b.pos.x, b.pos.y, other.pos.x, other.pos.y);
      }
    }
    b.display();
  }

  //// water
  //fill(0, 0, 255, 100);
  //rect(0, height - WATER_HEIGHT, width, height - WATER_HEIGHT);
}

void keyPressed() {
  PVector f = new PVector(1, 0);
  balls.get(0).applyForce(f);
}

class Ball {
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  float dia;

  Ball(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector(0.1, 0);
    mass = random(1, 10);
    dia = 10 * mass; //random(20, 30);
  }

  void update() {
    // acc --> vel --> pos
    vel.add(acc); // vel += acc;
    pos.add(vel); // pos += vel;
    acc.mult(0); // acc *= 0; acc will be released after is applied
  }

  void applyForce( PVector force ) {
    PVector f = force.copy();
    f.div(mass);
    acc.add(f);
  }

  void applyRestitution(float amount) {
    // coefficent of restitution
    float value = 1.0 + amount;
    vel.mult( value );
  }

  void display() {
    pushMatrix();
    pushStyle();

    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, dia, dia);

    popStyle();
    popMatrix();
  }

  void checkEdges() {
    // x
    if (pos.x > width) {
      pos.x = width;
      vel.x *= -1;
    } else if (pos.x < 0) {
      pos.x = 0;
      vel.x *= -1;
    }
    // y
    if (pos.y > height) {
      pos.y = height;
      vel.y *= -1;
      //applyRestitution( -0.50 );
    } else if (pos.y < 0) {
      pos.y = 0;
      vel.y *= -1;
    }
  }
}
