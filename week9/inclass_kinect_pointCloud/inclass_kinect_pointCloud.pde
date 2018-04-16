import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;


Kinect2 kinect2;
int kWidth, kHeight;
PImage depthImg;

int thresholdMin = 0;
int thresholdMax = 4499;
int resolution = 5;


ArrayList <Particle> particles = new ArrayList <Particle>();


void setup() {
  size(1000, 600, P3D);

  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initRegistered();
  kinect2.initDevice();

  kWidth =  kinect2.depthWidth;
  kHeight =  kinect2.depthHeight;

  depthImg = createImage(kWidth, kHeight, ARGB);
}

void draw() {
  background(0);

  // 3D Space
  pushMatrix();
  translate(width/2, height/2);
  rotateY(frameCount * 0.01);

  noFill();
  stroke(255);
  box(200);

  PImage colorImg = kinect2.getRegisteredImage().copy();
  colorImg.loadPixels();
  depthImg.loadPixels();

  depthImg.loadPixels();
  int[] rawDepth = kinect2.getRawDepth(); // length = 512*424; 0 - 4500(4.5m) but don't use "0"

  // use 2 forloops: x&y
  for (int i = 0; i < rawDepth.length; i ++) {
    int x = i % kWidth;
    int y = floor (i / kWidth);
    int depth = rawDepth[i]; // z value

    // manipulate the pixels
    if (depth >= thresholdMin
      && depth <= thresholdMax
      && depth != 0) {
      float r = map(depth, thresholdMin, thresholdMax, 255, 0);
      float b = map(depth, thresholdMin, thresholdMax, 0, 255);

      depthImg.pixels[i] = color(r, 0, b);

      if ( x % resolution == 0 && y % resolution == 0) {
        float px = map(x, 0, kWidth, -kWidth/2, kWidth/2);
        float py = map(y, 0, kHeight, -kHeight/2, kHeight/2);
        float pz = map(depth, 1, 4499, 500, -500);

        color c = colorImg.pixels[i];

        //strokeWeight(2);
        //stroke(c);
        //point(px, py, pz);

        particles.add( new Particle( px, py, pz, c) );
      }
    } else {
      depthImg.pixels[i] = color(0, 0);
    }
  }
  depthImg.updatePixels();

  for (int i = 0; i < particles.size(); i ++) {
    Particle p = particles.get(i);
    p.move();
    p.display();
  }

  while (particles.size() > 1000) {
    particles.remove( 0 );
  }

  popMatrix();

  // 2D Canvas
  image(kinect2.getDepthImage(), 0, 0, kWidth * 0.3, kHeight * 0.3);
  image(depthImg, 0, 0, kWidth * 0.3, kHeight * 0.3);
  //image(kinect2.getRegisteredImage(), 0, 0);


  fill(255);
  text(frameRate, 10, 20);
  
  saveFrame("data/frame" + frameCount + ".png");
}

void mousePressed() {
  thresholdMin = int( map(mouseX, 0, width, 0, 4499) ); // or: (int)+map(); floor(map())
}
void mouseDragged() {
  thresholdMax = int( map(mouseX, 0, width, 0, 4499) ); // or: (int)+map(); floor(map())
}
