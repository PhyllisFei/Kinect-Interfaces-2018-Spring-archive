PImage img;
String[] characters = {"",".","~","&","%","#","M","!"};

void setup() {
  size(800, 640);
  background(0);
  noStroke();

  img = loadImage("face.png");
  
  img.loadPixels();
  int w = img.width;
  int h = img.height;
  int circleSize = 10;
  for (int y = 0; y < h; y += circleSize) {
    for (int x = 0; x < w; x += circleSize) {
      int index = x + w*y;
      
      color c = img.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      
      float white = (r+g+b)/3; //avg
      int charIndex = int (map(white, 0, 255, 0, characters.length-1));
      
      fill(255);
      text(characters[charIndex], x, y);
      //ellipse(x,y,dia,dia);
      //img.pixels[index] = color(white);  
    }
  }
  //img.updatePixels();
  //image(img, 0, 0);
}

void draw() {
  //background(0);
}