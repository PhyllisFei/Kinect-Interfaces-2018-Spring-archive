void setup() {
  size(500, 600);
  background(0);
}

void draw() {
  stroke(255, 0, 0);
  strokeWeight(5);
  fill(255, 255, 0);
  
  beginShape();
  vertex(100, 100);
  vertex(100, 200);
  vertex(200, 200);
  endShape(CLOSE);
}

void mousePressed() {
  println(mouseX + " "+ mouseY);
}