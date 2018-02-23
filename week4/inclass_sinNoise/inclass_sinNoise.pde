float x, y1, y2;

void setup() {
  size(500, 600);
  background(0);
  noStroke();
  x = 0;
}

void draw() {
  stroke(150);
  line(0, height/2, width, height/2);
  noStroke();

  float amp = 300;
  float freq = frameCount * 0.01; //radians(frameCount);
  float noiseValue1 = noise(freq) * amp; // 0 to 1
  float noiseValue2 = noise(freq+100) * amp*0.5; // 0 to 1

  x ++;
  y1 = height/2 + noiseValue1;
  y2 = height/2 + noiseValue2;

  fill(255,0,0);
  ellipse(x, y1, 3, 3);
  fill(255,255,0);
  ellipse(x, y2, 3, 3);
}