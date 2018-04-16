float pmX, pmY;
float accX, accY;

void setup() {
  size(500, 600);
  background(0);
}

void draw() {
  //background(0);
  noStroke();
  fill(0, 20);
  rect(0, 0, width, height);

  accX = mouseX - pmouseX;
  accY = mouseX - pmouseY;

  float distance = dist(pmouseX, pmouseY, mouseX, mouseY);

  float sw = map(distance, 0, 100, 0, 20);
  strokeWeight(sw);
  stroke(255);
  line(pmouseX, pmouseY, mouseX, mouseY);

  textSize(25);
  text(accX, 30, 50);
  text(accY, 30, 50+40);

  if (accX > 200) {
    println("Swipe:RIGHT");
  }
  /*line(pmX,pmY,mouseX,mouseY);
   
   pmX = mouseX;
   pmY = mouseY; // also can use pmouseX */
}
