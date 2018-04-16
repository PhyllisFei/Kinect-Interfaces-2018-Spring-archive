"use strict";

class ParticleCenter {
  constructor(angle) {
    this.pos = createVector(0,0,0);
    this.vel = createVector(sin(radians(angle))*15, -15, cos(radians(angle))*15);
    this.acc = createVector();
    this.mass = 1;
    this.rad = this.mass*1.5;
    
    this.lifespan = 5.0;
    this.lifeDecrease = 0.05;
 
    this.isDead = false;

  }
  
  checkBoundary(){
    if(this.pos.y>=0){
      this.pos.y = 0;
      this.vel.y *= -0.7;
      this.vel.x *= 0.92;
      this.vel.z *= 0.92;
    }
  }

  updateLife(){
      this.lifespan -= this.lifeDecrease;
    if(this.lifespan <= 0){
      this.isDead = true;
    }
  }


  update() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
    this.rad -= 0.01;
  }
  
  display() {
    push();
    fill(250);
    translate(this.pos.x, this.pos.y, this.pos.z);
    sphere(this.rad);
    pop();
  }

  applyForce(force) {
    force.div(this.mass);
    this.acc.add(force);
  }

}