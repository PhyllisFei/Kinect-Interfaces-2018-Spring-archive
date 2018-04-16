"use strict";

class Test {
  constructor() {
    this.pos = createVector(0,0,0);
    this.mass = 0.8;

  }
 
  updateLife(){
    if(this.pos.y>0){
      this.pos.y = 0;
      this.isDeath = true;
     }
  }


  update() {

  }
  
  display() {

  }

  applyForce(force) {

  }

}