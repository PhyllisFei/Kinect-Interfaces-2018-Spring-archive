"use strict";

class Particle {
  constructor(x,a) {
    this.pos = createVector(0,0,0);
    this.vel = createVector(random(-0.2,0.2)+x, -4-a*4.5, random(-0.2,0.2));
    this.acc = createVector();
    this.mass = 1;
    this.rad = this.mass*1.2;
    this.a = 100;
    
    this.reachBottom = false;

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
      // this.lifespan -= this.lifeDecrease;
    }
    
    // if(this.lifespan <= 0){
    //   this.lifespan = 0;
    //   this.isDead = true;
    // }
  }


  update() {
    this.vel.add(this.acc);
    this.pos.add(this.vel);
    this.acc.mult(0);
    this.rad += 0.03;
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