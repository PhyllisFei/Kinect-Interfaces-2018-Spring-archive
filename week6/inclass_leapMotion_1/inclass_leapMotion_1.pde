import de.voidplus.leapmotion.*;

LeapMotion leap;

void setup() {
  size(800, 500, P3D);
  background(255);

  leap = new LeapMotion(this).allowGestures("circle");
}

void draw() {
  background(255);

  for (Hand hand : leap.getHands()) {
    //int     handId             = hand.getId();
    PVector handPosition       = hand.getPosition();
    PVector handStabilized     = hand.getStabilizedPosition();
    PVector handDirection      = hand.getDirection();
    PVector handDynamics       = hand.getDynamics();
    float   handRoll           = hand.getRoll();
    float   handPitch          = hand.getPitch();
    float   handYaw            = hand.getYaw();
    boolean handIsLeft         = hand.isLeft();
    boolean handIsRight        = hand.isRight();
    float   handGrab           = hand.getGrabStrength();
    float   handPinch          = hand.getPinchStrength();
    float   handTime           = hand.getTimeVisible();
    PVector spherePosition     = hand.getSpherePosition();
    float   sphereRadius       = hand.getSphereRadius();

    // --------------------------------------------------
    // Drawing
    hand.draw();

    Finger fIndex  =  hand.getMiddleFinger();
    PVector fIndexPos = fIndex.getPosition();

    if (handIsLeft) {
      fill(255, 0, 0, 100);
    } else if (handIsRight) {
      fill(255, 255, 0, 100);
    }
    noStroke();
    
    ellipse(fIndexPos.x, fIndexPos.y, 200 * handPinch, 200 * handPinch );
    
    fill(0);
    text(handPinch, 10, 20);
  }
}


// 2. Circle Gesture

void leapOnCircleGesture(CircleGesture g, int state){
  int     id               = g.getId();
  Finger  finger           = g.getFinger();
  PVector positionCenter   = g.getCenter();
  float   radius           = g.getRadius();
  float   progress         = g.getProgress();
  long    duration         = g.getDuration();
  float   durationSeconds  = g.getDurationInSeconds();
  int     direction        = g.getDirection();

  switch(state){
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      println("CircleGesture: " + id);
      break;
  }

  switch(direction){
    case 0: // Anticlockwise/Left gesture
     println("Anticlockwise");
      break;
    case 1: // Clockwise/Right gesture
    println("Clockwise");
      break;
  }
}