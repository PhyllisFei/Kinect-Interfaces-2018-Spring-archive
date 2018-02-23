float accX, accY;

void setup() {
  background(0);
  size (500, 600);
  frameRate(3);
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
  textSize(25);
  text(accX, 30, 50);
  text(accY, 30, 50+40);

  if (accX > 200) {
    println("Swipe: RIGHT");
  }
}