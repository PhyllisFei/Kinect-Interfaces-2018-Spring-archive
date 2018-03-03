class Button {
  // varialble
  float posX, posY;
  float rad;
  boolean state;
  int hitCount;
  color clr;

  // constructor
  Button(float x, float y, float r) {
    posX = x;
    posY = y;
    rad = r;
    state = false;
    hitCount = 0;
    clr = color (random(255), random(255), random(255));
  }

  //functions
  void checkDistance(float otherX, float otherY) {
    float distance = dist(posX, posY, otherX, otherY);
    if (distance < rad) {
      hitCount++;
    }
  }
  void updateHitCount() {
    //println(hitCount);
    if (hitCount > 1000) {
      state = true;
    } else {
      state = false;
    }
    hitCount = 0;
  }

  void display() {
    pushStyle();

    if (state == true) {
      noStroke();
      fill(clr);
    } else {
      noFill();
      stroke(clr);
      strokeWeight(5);
    }
    ellipse(posX, posY, rad * 2, rad * 2);

    popStyle();
  }
}