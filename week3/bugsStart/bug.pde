class Bug {
  float xSpd, ySpd;
  float x, y, size;
  float r, g, b;
  float freq = random (0.05, 0.08);
  float amp = random (2, 5);
  int state=0;

  //int state = 0;

  boolean prevPress = false ;

  Bug(float _x, float _y) {
    x = _x;
    y = _y;
    xSpd = 0;
    ySpd = 0;

    size = 15;
    color(255);
  }

  void update() {
    xSpd = noise(frameCount*freq + 100) * amp - amp/2;
    ySpd = noise(frameCount*freq) * amp - amp/2;
    x += xSpd;
    y += ySpd;

    checkState();
  }
  void checkState() {
    float distance = dist(x, y, mouseX, mouseY);

    boolean currPress = false;
    if (distance < size*1.5) {
      if (mousePressed) {
        currPress = true;
        if (!prevPress) {
          //triggered
          state = 1;
        } else {
          //onPress
          state = 2;
        }
      } else if (prevPress) {
        //released
        state = 3;
      } else {
        state = 0;
      }
      //println(prevPress + "  " + currPress);
      prevPress = currPress;
    }
  }


  void display() {
    fill(255);
    ellipse(x, y, size, size*1.5);

    pushStyle();
    switch (state) {
    case 0:
      fill(0, 130, 130);
      ellipse(x, y, size, size);
      break;
    case 1: // triggered
      fill(255, 0, 0);
      ellipse(x, y, size*5, size*5);
      break;
    case 2: // on press
      noStroke();
      fill(255, 0, 255);
      ellipse(x, y, size*0.5, size*1.5);
      break;
    case 3: // released
      x = random(width);
      y = random(height);
      //frameCount = 10000;
      fill(255, 0, 0);
      ellipse(x, y, size, size);
      break;
    }
    popStyle();

    if (x<0||x>width) {
      x += -x;  //???x *= -1;
    }
    if (y<0||y>height) {
      y += -y;  //???y *= -1;
    }
    //if (x > width) {
    //  x = 0;
    //} else if (x < 0) {
    //  x = width;
    //}
  }
}