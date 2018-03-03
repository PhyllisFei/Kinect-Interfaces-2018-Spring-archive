ArrayList<Bug> bugs = new ArrayList<Bug>();

void setup() {
  size(500, 500);
  noStroke();
  bugs.add( new Bug(random(width), random(height)));
  bugs.add( new Bug(random(width), random(height)));
  bugs.add( new Bug(random(width), random(height)));
  bugs.add( new Bug(random(width), random(height)));
  bugs.add( new Bug(random(width), random(height)));
}

void draw() {
  background(0);

  if (keyPressed) {
    int count = 0;
    for (int i=0; i<bugs.size(); i++) {
      Bug b = bugs.get(i);
      b.update();
      b.display();
      
      if(b.state==2){
        count ++;
      }
    }
    if (count>=2) {
      background(100);
    }
  }
}