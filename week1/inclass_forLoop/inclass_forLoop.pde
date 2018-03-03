void setup() {
  size(500, 600);
  background(100);
  noStroke();

  //one way
  int rectSize = 20;
  for (int i=0; i<5; i++) {
    float x = rectSize * i;
    float y = height * 1/3;
    fill(random(width), random(width), random(width));
    rect(x, y, rectSize, rectSize);
  }

  //another way
  //for (int x = 0; x<width; x+=rectSize) {
  //  for (int y = 0; y<height; y+=rectSize) {

  //    //float y = height * 2/3;
  //    fill(random(width), random(width), random(width));
  //    rect(x, y, rectSize, rectSize);
  //}
  // }
}


void draw() {
  for (int x = 0; x<width; x+=rectSize) {
    for (int y = 0; y<height; y+=rectSize) {

      //float y = height * 2/3;
      fill(random(width), random(width), random(width));
      rect(x, y, rectSize, rectSize);
    }
  }
}