float accX, accY;

void setup() {
  background(0);
  size (500, 600);
}

void draw() {
  //trail effect
  noStroke();
  fill(0, 20);
  rect(0, 0, width, height);

  float distance = dist(pmouseX, pmouseY, mouseX, mouseY);
  //distance == pixel per frame
  
  accX = mouseX-pmouseX;
  accY = mouseY-pmouseY;
  
  float sw = map(distance, 0, 100, 0, 20);

  strokeWeight(sw);
  stroke(255);
  line(pmouseX, pmouseY, mouseX, mouseY);
}