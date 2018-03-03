float x, y;

void setup() {
  size(600, 200);
  background(50);
}

void draw() {
  background(50);
  x = lerp(x, mouseX, 0.2);
  y = lerp(y, mouseY, 0.2);
  
  ellipse(x, y, 50, 50);
}