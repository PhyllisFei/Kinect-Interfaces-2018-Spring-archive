float x, y;
float xSpd, ySpd;

void setup() {
  size(500,600);
  background(0);
  noStroke();
  
  x = width/2;
  y = height/2;
  xSpd = 0;
  ySpd = 0;
}

void draw() {
  float freq = 0.05;
  int amp = 5;
  xSpd = noise(frameCount*freq + 100) * amp - amp/2;
  ySpd = noise(frameCount*freq) * amp - amp/2;
  x += xSpd;
  y += ySpd;
  
  fill(255);
  ellipse(x, y, 5, 5);
  
  
}