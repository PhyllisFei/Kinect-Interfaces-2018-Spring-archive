PImage img;

void setup() {
  size(500, 600);
  background(0);
  img = createImage(width, height, RGB);
}

void draw() {
  background(0);

  img.loadPixels();
  //to see pixel calculation: println(img.pixels.length);
  for (int index = 0; index < img.pixels.length; index++) {
    int x = index % img.width; 
    int y = floor(index / img.width); //or use "int"
    
    float spd = 5.0;
    float amp = 1;
    float freq = (frameCount * spd + y + x) * 0.01;  //time, position
    float value = noise( freq )* amp;
    
    float w = map(value, 0, 1, 0, 255);
    
    img.pixels[index] = color(w);
  }
  img.updatePixels();
  
  image(img,0,0);
}