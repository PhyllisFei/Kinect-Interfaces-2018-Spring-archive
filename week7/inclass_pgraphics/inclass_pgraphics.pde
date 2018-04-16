import codeanticode.syphon.*;

PGraphics pg;
SyphonServer server;

void setup() {
  size(500, 600, P3D);
  
  pg = createGraphics(width, height);
  server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  background(0);
  
  pg.beginDraw();
  
  pg.fill(random(255), random(255), random(255));
  pg.rect(0, 0, width/2, height/2);
  
  pg.fill(255, 255, 0);
  pg.rect(0,  height/2, width/2, height/2);
  
  pg.fill(0, 255, 0);
  pg.rect(width/2, 0, width/2, height/2);
  
  pg.fill(0, 0, 255);
  pg.rect(width/2, height/2, width/2, height/2);
  
  pg.endDraw();
  
  image(pg, 0, 0);
  server.sendImage(pg);
}