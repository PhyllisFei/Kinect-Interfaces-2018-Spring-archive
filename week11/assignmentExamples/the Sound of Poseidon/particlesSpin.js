"use strict";

class ParticleSpin {
  constructor(f) {
    this.pos = createVector(0,0,0);
    this.vel = createVector(sin(f*10)*8, -30,cos(f*10)*8);
    //frameCount
    this.acc = createVector();
    this.mass = 0.8;
    this.rad = this.mass*2;
    this.a = 100;
    
    this.lifespan = 1;
    this.lifeDecrease = 0.01;
    this.isDead = false;
  }
  
  checkBoundary(){
    if(this.pos.y>=0){
      this.pos.y = 0;
      this.vel.y *= -0.7;
      this.vel.x *= 0.9;
      this.vel.z *= 0.9;
    }
  }
 
  updateLife(){
    if(this.lifespan<0){
      this.isDead = true;
     }
    this.rad -= 0.01;
  }
  update() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
    this.lifespan -= this.lifeDecrease;
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