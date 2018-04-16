float handX, handY;
float fingerIndexX, fingerIndexY, fingerThumbX, fingerThumbY;
float pfingerIndexX, pfingerIndexY;

void setup() {
  size(800, 500, P3D);
  background(255);

  LeapMotion_setup();
}

void draw() {
  background(255);

  LeapMotion_run();

  float distance = dist(fingerIndexX, fingerIndexY, fingerThumbX, fingerThumbY);
  if (distance < 40) {
    //pinch
    //background(0, 255, 0);
  }
  float accel = dist(pfingerIndexX, pfingerIndexY, fingerIndexX, fingerIndexY);
  if (accel > 30) {
    println("swiped");
    println("x:" + (fingerIndexX - pfingerIndexX));
    println("y:" + (fingerIndexY - pfingerIndexY));
    println("___");
  }


  noStroke();
  fill(255, 0, 0);
  ellipse(fingerIndexX, fingerIndexY, 5, 5);
  fill(255, 255, 0);
  ellipse(fingerThumbX, fingerThumbY, 5, 5);

  stroke(255, 0, 0);
  strokeWeight(accel);
  line(pfingerIndexX, pfingerIndexY, fingerIndexX, fingerIndexY);

  fill(0);
  text(distance, 10, 20);

  pfingerIndexX = fingerIndexX;
  pfingerIndexY = fingerIndexY;
}