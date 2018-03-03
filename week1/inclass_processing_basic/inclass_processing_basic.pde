float dia ;
color c;

void setup() {
  size(500, 600); //(w,h)
  noStroke();
  c = color(255);
  background(100);
}

void draw() {  
  fill(0,10);
  rect(0,0,width,height);
  dia = random(1, 30);


  //compare
  if (mousePressed == true) {
    fill(c);
    ellipse(mouseX, mouseY, dia, dia); //x,y,w,h
  }
}



void mousePressed() {
  c = color(random(255), random(255), random(255));
}