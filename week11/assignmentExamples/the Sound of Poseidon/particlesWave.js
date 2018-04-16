"use strict";

class ParticleWave {
  constructor(f) {
    this.pos = createVector(0,0,0);
    this.vel = createVector(random(-0.3,0.3), -12-sin(f+frameCount*0.1)*2, random(-0.3,0.3));
    //frameCount
    this.acc = createVector();
    this.mass = 0.5;
    this.rad = this.mass*1.5;
    this.a = 100;
    this.isDead = false;
  }
 
  updateLife(){
    if(this.pos.y>0){
      this.pos.y = 0;
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