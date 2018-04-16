"use strict";

class ParticleSway {
  constructor(x,a) {
    this.pos = createVector(0,0,0);
    this.vel = createVector(random(-0.4,0.4)+x, -3-a*4, random(-0.3,0.3));
    this.acc = createVector();
    this.mass = 0.6;
    this.rad = this.mass*2;
    this.a = 100;
    this.reachBottom = false;
    
    this.lifespan = 1;
    this.lifeDecrease = 0.05;
    
    this.isDead = false;
  }
  
  
  checkBoundary(){
    if(this.pos.y>0){
      this.pos.y = 0;
      this.reachBottom = true;
    }
  }

  updateLife(){
    if(this.reachBottom == true){
      this.isDead = true;
    }
    
  }


  update() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
    this.rad -= 0.01;
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