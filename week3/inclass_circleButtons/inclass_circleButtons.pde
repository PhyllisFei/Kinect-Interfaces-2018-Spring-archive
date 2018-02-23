int btnX, btnY;
float btnSize;

void setup() {
  size(500, 600);
  background(50);
  rectMode(CENTER);
  btnX = 100;
  btnY = 200;
  btnSize = 100;
}

void draw() {
  background(50);

  float freq = frameCount * 0.05;   //or use: radians(frameCount);
  float amp = 20;
  float sinValue = sin(freq) * amp;

  btnSize = 100 + sinValue; //80 - 120

  float distance = dist(mouseX, mouseY, btnX, btnY);
  if (distance < btnSize/2) {
    //on the area
    fill(255);
    noStroke();
  } else {
    //no
    noFill();
    stroke(255);
  }
    ellipse (btnX, btnY, btnSize, btnSize);
    fill(255, 0, 0);
    text(distance, mouseX, mouseY);
  }