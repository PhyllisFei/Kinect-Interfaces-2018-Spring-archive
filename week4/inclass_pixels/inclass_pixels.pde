PImage img;
int c;

void setup() {
  size(500, 500);
  background(0);
  noStroke();

  img = loadImage("colorful.jpg");

  for (int i = 0; i < 50000; i++) {
    int x = int (random(width));
    int y = int (random(height));
    color c = img.get(x, y);


    float dia = random (5, 20);
    fill(red(c), green(c), blue(c), 150);
    ellipse(x, y, dia, dia);
  }
  //for (int y = 0; y < img.height; y ++) {
  //  for (int x = 0; x < img.width; x ++) {
  //  }
  //}

  c = color(255);
}

void draw() {
  //background(0);
  ////change the image scale: scale(5.0, 5.0);
  //image(img, 0, 0);

  //fill(c);
  //rect(30, 30, 50, 50);
}

//void mousePressed() {
//  c = img.get(mouseX, mouseY);
//}