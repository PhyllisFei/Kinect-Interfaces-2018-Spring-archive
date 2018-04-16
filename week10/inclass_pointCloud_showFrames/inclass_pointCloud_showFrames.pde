ArrayList<PImage> frames = new ArrayList<PImage>();

import controlP5.*;

ControlP5 cp5;

int framesIndex;

void setup() {
  size(800, 500, P3D);

  String path = sketchPath("data/png");
  println(path);
  File file = new File( path );
  if (file.isDirectory()) {
    String filenames[] = sort(file.list());  
    printArray(filenames);
    for (int i = 0; i < filenames.length; i ++) {
      PImage img = loadImage("data/png/" + filenames[i]);
      frames.add(img);
    }
  }
  cp5 = new ControlP5(this);
  cp5.addSlider("frameIndex")
    .setSize(width -60, 20)
    .setPosition(10, height - 30)
    .setRange(0, frames.size()-1)
    ;
}

void draw() {
  background(0);

  PImage depthImg = frames.get(framesIndex);

  if (depthImg != null) {
    image(depthImg, 0, 0);
  }
  
  depthImg.loadPixels();
  for (int y = 0; y < depthImg.height; y += 3) {
    for (int x = 0; x < depthImg.width; x += 3) {
      int i = x + y * depthImg.width;
      float depth = red(depthImg.pixels[i]);
      
      float px, py, pz;
      px = map(x, 0, depthImg.width, -depthImg.width/2, depthImg.width/2);
      py = map(y, 0, depthImg.height, -depthImg.height/2, depthImg.height/2);
      pz = map(depth, 0, 255, 500, -500);
      stroke(255);
      strokeWeight(3);
      point(px, py, pz);
    }
  }
}
