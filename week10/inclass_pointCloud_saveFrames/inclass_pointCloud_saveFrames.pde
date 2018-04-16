import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;

Kinect2 kinect2;


void setup() {
  size(515, 424, P2D);
  kinect2 = new Kinect2(this);

  kinect2.initDepth();
  kinect2.initDevice();
}

void draw() {
  background(0);
  image(kinect2.getDepthImage(), 0, 0);
  
  saveFrame("data/png/frames-#####.png");
  
  text(frameRate, 10, 20);
  text(frameCount, 10, 20);
}
