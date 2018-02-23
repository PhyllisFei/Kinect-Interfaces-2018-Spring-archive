int btnX, btnY;
float btnW, btnH;

void setup() {
  size(500, 600);
  background(50);
  rectMode(CENTER);
  btnX=100;
  btnY=200;
  btnW=120;
  btnH=150;}

void draw() {
  background(50);
  
  float freq = frameCount * 0.05;   //or use: radians(frameCount);
  float amp = 20;
  float sinValue = sin(freq) * amp;
  btnW = 120 + sinValue;   // 100 - 140
  btnW = 150 + sinValue;
  
  if (mouseX > btnX - btnW/2 && mouseX <btnX+btnW/2 
    && mouseY > btnY - btnH/2 && mouseY < btnY + btnH/2 ) {
    fill(255, 0, 0);
    noStroke();
  } else {
    noFill();
    stroke(255, 0, 0);
  }
  rect(btnX, btnY, btnW, btnH);
}