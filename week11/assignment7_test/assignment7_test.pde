import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;

Kinect2 kinect2;

PGraphics depthImg;
boolean draw;
int thresholdMin = 0;
int thresholdMax = 4499;

ArrayList<Circle> circles = new ArrayList<Circle>();

void setup() {
  size(512, 424, P2D);

  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();  

  noStroke();

  depthImg = createGraphics(kinect2.depthWidth, kinect2.depthHeight);
}

void draw() {
  background(0);

  int[] rawDepth = kinect2.getRawDepth();

  // show portrait
  depthImg.loadPixels();
  for (int i=0; i < rawDepth.length; i++) {
    int depth = rawDepth[i];

    if (depth >= thresholdMin
      && depth <= thresholdMax
      && depth != 0) {
        
      draw = true;

      int x = i % kinect2.depthWidth;
      int y = floor(i / kinect2.depthWidth);


      float r = map(depth, thresholdMin, thresholdMax, 255, 0);
      float b = map(depth, thresholdMin, thresholdMax, 0, 255);

      circles.add( new Circle( x, y, random(5), depthImg) );
      circles.add( new Circle( x, y, random(5), depthImg) );

      depthImg.pixels[i] = color(r, 0, b);
    } else {
      depthImg.pixels[i] = color(0, 0);
    }
  }
  depthImg.updatePixels();

  image(kinect2.getDepthImage(), 0, 0);
  image(depthImg, 0, 0);
  

  // draw/erase on PGraphic
  depthImg.beginDraw();
  // update & draw circles
  for (int i=0; i<circles.size(); i++) {
    circles.get(i).update();
    circles.get(i).displayIn( depthImg );
  }
  depthImg.endDraw();

  for (int i=circles.size()-1; i>=0; i--) {
    if (circles.get(i).alpha <= 0) {
      circles.remove(i);
    }
  }

  image(depthImg, 0, 0);
}


class Circle {
  float x, y;
  float size;
  color c;
  int alpha;
  float speed;
  float directionX, directionY;

  Circle(float _x, float _y, float _size, PImage _cam) {
    x = _x;
    y = _y;
    size = _size;

    // right hand to draw face; left hand to erase
    if (draw == true) {
      c = _cam.get(int(x), int(y));
      alpha = 100;
      directionX = random(-1, 1);
      directionY = random(-1, 1);
      speed = 0.4;
    } else {
      c = (0);
      alpha = 155;
      directionX = random(-1, 1);
      directionY = random(-1, 1);
      speed = 0.8;
    }
  }

  void update() {
    x = x + directionX*speed;
    y = y + directionY*speed;
    alpha -= 1.5;
    speed *= 1.02;
  }
  void display() {
    pushStyle();
    fill(c, 105);
    noStroke();
    ellipse(x, y, size, size);
    popStyle();
  }
  void displayIn( PGraphics p ) {
    p.pushStyle();
    p.fill(c, 105);
    p.noStroke();
    p.ellipse(x, y, size, size);
    p.popStyle();
  }
}
