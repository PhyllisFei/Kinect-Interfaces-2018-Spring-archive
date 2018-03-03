//ArrayList<DataType> variableName = new ArrayList<DataType>();

void setup() {
  size(700, 700, P3D);  
  background(0);
}

void draw() {
  background(0);
  spotLight(255, 0, 0, width/2, height/2, 400, 0, 0, -1, PI/4, 2);
  //pushMatrix();
  translate(width/2, height/2, -150);
  stroke(40);
  sphere(210);
  //popMatrix();
  //camera(mouseX, mouseY, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  //shape(sphere);
}