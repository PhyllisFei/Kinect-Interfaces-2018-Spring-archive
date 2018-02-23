PImage img;

void setup() {
  size(500, 600);
  background(0);
  noStroke();

  img = createImage(width, height, RGB); // w,h,clrSet(ARGB)
}

void draw() {
  //FBO: Frame Buffer Object search!!!!

  img.loadPixels();
  
  //println(img.pixels.length); // 500*600
  
  int index = 0;
  for (int y=0; y < img.height; y ++) {
    for (int x=0; x < img.width; x ++) {
      
      float distance = dist( mouseX, mouseY, x, y);
      
      float freq = (distance + frameCount)* 0.1; //time, agnle, position
      float amp = 1;
      float sineValue = sin(freq) * amp;
      
      float r = map(x, 0, width, 0, 255);
      float g = map(sineValue, -1, 1, 255, 0);;
      float b =  map(y, 0, height, 0, 255);
      img.pixels[index] = color(r,g,b);//( random(255), random(255), random(255) );;
      index++;
    }
  }
  img.updatePixels();
  
  image(img,0,0);
  
  fill(255);
  textSize(20);
  text(frameRate, 20, 30);
}