class Button {
  float posX, posY;
  float size;
  float r, g, b; // color
  int state = 0;
  /** 
   state
   0: not pressed
   1: hover
   2: triggered
   3: on press
   4: released
   **/
  boolean prevPress = false;
  SoundFile sound;
  float soundRate = random(0.6, 1.5);


  Button(float x, float y, SoundFile snd) {
    posX = x;
    posY = y;

    size = 100;

    r = random(255);
    g = random(255);
    b = random(255);
    
    sound = snd;
  }

  void update() {
    checkState();
  }
  void checkState() {
    float distance = dist(posX, posY, mouseX, mouseY);

    boolean currPress = false;
    if (distance < size/2) {
      //hover
      state = 1;
      if (mousePressed) {
        currPress = true;
        if (!prevPress) {
          //triggered
          state = 2;
        } else {
          //onPress
          state = 3;
        }
      } else if (prevPress) {
        //released
        state = 4;
      } else {
        state = 0;
      }
      //println(prevPress + "  " + currPress);
      prevPress = currPress;
    }
  }
  void display() {
    pushStyle();

    switch (state) {
    case 0:
      stroke(r, g, b);
      fill(r, g, b, 255);
      ellipse(posX, posY, size, size);
      break;
    case 1: // hover
      stroke(r, g, b);
      fill(r, g, b, 150);
      ellipse(posX, posY, size, size);
      break;
    case 2: // triggered
      stroke(r, g, b);
      noFill();
      ellipse(posX, posY, size*1.5, size*1.5);
      sound.rate(soundRate);
      sound.play();
      break;
    case 3: // on press
      stroke(r, g, b);
      fill(r, g, b);
      ellipse(posX, posY, size*0.9, size*0.9);
      break;
    case 4: // released
      posX = random(width);
      posY = random(height);
      //stroke(r, g, b);
      //fill(r, g, b, 150);
      //ellipse(posX, posY, size, size);
      break;
    }

    popStyle();
  }
}