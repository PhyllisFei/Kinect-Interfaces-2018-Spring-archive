class Ball {
  float x, y, size;
  color clr;
  float xspeed, yspeed;
  boolean isDone;
  
  float lifespan = 1.0; //100%
  float lifeReduction = random(0.010, 0.001);

  Ball(float tempX, float tempY) {
    x = tempX;
    y = tempY;
    size = random(3, 5);
    clr = color(random(150, 255));

    xspeed = random(-2, 2);
    yspeed = random(-2, 2);

    isDone = false;
  }

  void display() {
    fill(clr);
    ellipse(x, y, size * lifespan, size * lifespan); // we change the size based on the lifespan :D
  }
  void move() {
    x += xspeed;
    y += yspeed;
  }
  void bounce() {
    if (x < 0) {
      xspeed = -xspeed;
    } else if (x > width) {
      xspeed = -xspeed;
    }
    if (y < 0) {
      yspeed = -yspeed;
    } else if (y > height) {
      yspeed = -yspeed;
    }
  }
  void checkOutOfCanvas() {
    if (x < 0 || x > width) {
      isDone = true;
    }
    if (y < 0 || y > height) {
      isDone = true;
    }
  }
  void updateLifespan() {
    lifespan -= lifeReduction;
    lifespan = constrain(lifespan, 0.0, 1.0);
    
    if (lifespan <= 0.0) {
      isDone = true;
    }
  }
  void connectLine( Ball other ) {
    float distance = dist(x,y,other.x,other.y);
    if (distance < 50) {
      float alpha = map(distance, 0 , 50, 255, 0);
      stroke(255, alpha);
      line(x,y,other.x,other.y);
    }
  }
}