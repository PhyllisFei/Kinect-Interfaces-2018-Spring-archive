ArrayList<Button> buttons = new ArrayList<Button>();

void setup() {
  size(500, 600);
  buttons.add( new Button(width/2 - 150, height/2, 150));
  buttons.add( new Button(width/2 + 150, height/2, 150));
}

void draw() {
  background(50);
  for (int i=0; i<buttons.size(); i++) {
    Button b = buttons.get(i);
    b.checkDistance(mouseX, mouseY);
    b.display();
  }
}

class Button {
  float posX, posY;
  float size;
  color clr;
  int state;
  /**
   0: nothing
   1: hovering
   2: on press
   **/

  Button(float x, float y, float s) {
    posX = x;
    posY = y;
    size = s;
    clr = color(255);
  }
  void update() {
    //
  }
  void checkDistance(float otherX, float otherY) {
    float distance = dist(posX, posY, otherX, otherY);
    if (distance < size/2) {
      //hovering
      if (mousePressed) {
        //on press
        state = 2;
        clr = color(random(255), random(255), random(255));
      } else {
        clr = color(255);
      }
    }
  }
  void display() {
    pushStyle();

    switch (state) {    
    case 0:   //none
      fill(clr);
      noStroke();
      ellipse (posX, posY, size, size);
      break;
    case 1:   //hovering
      noFill();
      stroke(clr);
      ellipse (posX, posY, size, size);
      break;
    case 2:   //on press
      fill(clr);
      ellipse (posX, posY, size, size);
      break;
    }

    popStyle();
  }
}