import de.voidplus.leapmotion.*;

LeapMotion leap;

void LeapMotion_setup() {
  leap = new LeapMotion(this);
}

void LeapMotion_run() {
  for (Hand hand : leap.getHands ()) {

    isHandDetected = true;

    PVector handPosition = hand.getPosition();
    handX = handPosition.x;
    handY = handPosition.y;

    boolean handIsLeft         = hand.isLeft();
    boolean handIsRight        = hand.isRight();

    if (handIsLeft) {
      handR = false;
    } else if (handIsRight) {
      handR = true;
    }

    image(cursor, handX, handY, 100.89, 75.56);
    
  }
}
