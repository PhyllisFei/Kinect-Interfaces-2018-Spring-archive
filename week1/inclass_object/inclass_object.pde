//
int number = 0;
//ArrayList<DataType> variableName = new ArrayList<DataType>();
ArrayList<Ball> balls = new ArrayList<Ball>();
//without ArrayList: Ball[] balls;


void setup() {
  size(500, 600);
  background(0);

  //number = new float[10];
  //balls = new Ball[10];
  for (int i=0; i<100; i++) {
    //without ArrayList: balls[i] = new Ball(random(width), random (height));
    balls.add( new Ball(random(width), random (height)));
  }
}

void draw() {
  background(0);
  //without ArrayList: for (int i=0; i<balls.length; i++) {
  //balls[i].move();
  //balls[i].display();
  for (int i=0; i< balls.size(); i++) {
    Ball b = balls.get(i);
    b.move();
    b.checkEdges();
    b.display();
  }

  //Example2
  for (int i=balls.size()-1;i>=0; i--) {
    Ball b = balls.get(i);
    if (b.isDone==true) {
      balls.remove(i);
    }
  }
  
  //Example1
  //if (balls.size()>100){
  //balls.remove(0);
  //}

  fill (255);
  text(balls.size(), 10, 20);
}

void mouseMoved() {
  balls.add( new Ball(mouseX, mouseY));
}