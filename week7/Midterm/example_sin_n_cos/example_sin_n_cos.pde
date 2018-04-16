
float rectX, rectY;
float rectWidth, rectHeight;


void setup() {
  size(600, 600);
  background(0);



  rectX = 150;
  rectY = 150;
  rectWidth = 300;
  rectHeight = 300;

  stroke(255);
  noFill();
  rect(rectX, rectY, rectWidth, rectHeight);

  float centerX = rectX + rectWidth/2;
  float centerY = rectY + rectHeight/2;

  fill(255, 0, 0);
  ellipse(centerX, centerY, 10, 10);

  // rect area
  noStroke();
  fill(255);
  //for (int i=0; i<500; i++) {
  //  float x = centerX + random(-rectWidth/2, rectWidth/2);
  //  float y = centerY + random(-rectHeight/2, rectHeight/2);
  //  ellipse(x, y, 20, 20);
  //}

  // circular
  for (int i=0; i<500; i++) {
    float angle = radians( random(360) );
    float radius = random(0, rectWidth/2);
    
    float cosValue = cos(angle) * radius;
    float sinValue = sin(angle) * radius;
    
    float x = centerX + cosValue;
    float y = centerY + sinValue;
    
    float distance = dist(centerX, centerY, x, y);
    float ellipseSize = map(distance, 0, rectWidth/2, 20, 1);
    
    ellipse(x, y, ellipseSize, ellipseSize);
  }


  //background(0);
}

void draw() {
  //background(0);
  //drawSinCos();
}



void drawSinCos() {
  noStroke();

  float angle = radians( frameCount * 2 ); // deg to rad
  float distance = 100; // radius
  float sinValue = sin(angle) * distance;
  float cosValue = cos(angle) * distance;

  fill(255, 255, 0);
  ellipse(frameCount, height/2 + sinValue, 5, 5);
  fill(0, 0, 255);
  ellipse(width/2 + cosValue, frameCount, 5, 5);

  float x = width/2 + cosValue; 
  float y = height/2 + sinValue;

  //strokeWeight(5);
  stroke(0);
  fill(255, 0, 0);
  ellipse(x, y, 15, 15);
}
