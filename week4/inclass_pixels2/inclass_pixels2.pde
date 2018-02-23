PImage img;
PImage colorSampleImg;
color[] colorSamples;

void setup() {
  size(800, 640);
  background(0);
  noStroke();

  img = loadImage("face.png");
  colorSampleImg = loadImage("gradationSample.png");
  colorSamples = new color[colorSampleImg.width]; //256*3

  colorSampleImg.loadPixels();
  for (int i = 0; i < colorSampleImg.width; i++) {
    colorSamples[i] = colorSampleImg.pixels[i];
  }

  img.loadPixels();
  int w = img.width;
  int h = img.height;
  for (int y = 0; y < h; y ++ ) {
    for (int x = 0; x < w; x ++ ) {
      int index = x + w*y;

      color c = img.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);

      int sum = int (r + g + b); // 255 + 255+ 255 + 1 = 766 == 768
        img.pixels[index] = colorSamples[sum];
      
      //  if (b*1.8 > r + g) {
      //  img.pixels[index] = color(r, g+120, b+100);
      //} else {
      // /img.pixels[index] = color(0);
      //}
    }
  }
  img.updatePixels();
  image(img, 0, 0);
}

void draw() {
  //background(0);
}