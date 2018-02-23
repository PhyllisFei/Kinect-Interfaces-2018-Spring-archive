// IMA NYU Shanghai
// Kinetic Interfaces
// MOQN
// Feb 7 2018
ArrayList<Button> buttons = new ArrayList<Button>();

void setup() {
  size(500, 500);
  stroke(255, 0, 0);
  buttons.add( new Button(width/2, height/2));
}


void draw() {
  background(100);

  for (int i=0; i<buttons.size(); i++) {
    Button b = buttons.get(i);
    b.update();
    b.display();
  }
}