import processing.video.*;


Capture cam;
ArrayList<Particle> particles = new ArrayList<Particle>(); 


void setup() {
  size(640, 480);
  noStroke();
  ellipseMode(CORNER);

  cam = new Capture(this, width, height);
  cam.start();
}


void draw() {
  pushStyle();
  fill(0, 15);
  noStroke();
  rect(0, 0, width, height);
  popStyle();

  if (cam.available()) {
    cam.read();
    cam.loadPixels();
  }

  if (particles.size() < 500) {
    particles.add( new Particle(width, random(height)) );
  }


  for (int i=0; i<particles.size(); i++) {
    Particle p = particles.get(i);
    p.update();
    p.checkEdge();

    int colorIndex = floor(p.posX) + floor(p.posY) * cam.width;
    if (colorIndex < cam.pixels.length) {
      p.updateColor( cam.pixels[colorIndex] );
    }

    p.display();
  }
}