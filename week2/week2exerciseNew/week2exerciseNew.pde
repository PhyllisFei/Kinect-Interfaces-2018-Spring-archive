void setup() {
  size(700, 700,P3D);
  noStroke();
}


void draw() {
  background(0);
  spotLight(255, 0, 0, width/2, height/2, 400, 0, 0, -1, PI/4, 2);
  translate(width/2, height/2, -150);
  stroke(40);
  sphere(210);
  
}