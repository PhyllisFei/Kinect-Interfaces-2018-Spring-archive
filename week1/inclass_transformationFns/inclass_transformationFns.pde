void setup() {
  size(500, 600);
  background(100);
}

void draw() {
  background(100);

  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(frameCount*0.5));
  fill(255, 255, 0);
  rect(0, 0, 200, 200);
  popMatrix();

  translate(200, 200);
  rotate(radians(frameCount*2));
  fill(255, 0, 0);
  rect(0, 0, 30, 30);
}