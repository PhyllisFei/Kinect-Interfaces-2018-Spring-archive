"use strict";

class ParticleSmall {
  constructor() {
    this.pos = createVector(0, 0, 0);
    this.vel = createVector(random(-1.5, 1.5), -6, random(-1.5, 1.5));
    this.acc = createVector();
    this.mass = 1;
    this.rad = this.mass * 1;
    this.a = 100;

    this.reachBottom = false;
    this.isDead = false;
  }

  checkBoundary() {
    
    if (this.pos.y >= 0) {
      this.pos.y = 0;
      this.reachBottom = true;
    }
  }

  updateLife() {
    if (this.reachBottom == true) {
      this.isDead = true;
    }

  }


  update() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
  }

  display() {
    push();
    translate(this.pos.x, this.pos.y, this.pos.z);
    sphere(this.rad);
    pop();
  }

  applyForce(force) {
    force.div(this.mass);
    this.acc.add(force);
  }

}