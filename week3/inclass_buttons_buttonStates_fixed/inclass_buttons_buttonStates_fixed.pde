
import processing.sound.*;

SoundFile sound;

// IMA NYU Shanghai
// Kinetic Interfaces
// MOQN
// Feb 7 2018
ArrayList<Button> buttons = new ArrayList<Button>();

void setup() {
  size(500, 500);

  sound = new SoundFile(this, "sound.wav");
  sound.play();

  buttons.add( new Button(random(width), random(height), sound));
  buttons.add( new Button(random(width), random(height), sound));
  buttons.add( new Button(random(width), random(height), sound));
}


void draw() {
  background(100);


  int count = 0;
  for (int i=0; i<buttons.size(); i++) {
    Button b = buttons.get(i);
    b.update();
    b.display();

    if (b.state == 2) {
      count ++;
    }
  }
  if (count >= 2) {
    background(255);
  }
}