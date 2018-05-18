import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400, 400);
  oscP5 = new OscP5(this, 12000);
}

void draw() {
  //
}

void oscEvent(OscMessage msg) {
  String tag = msg.typetag();
  
  if(tag.equals("iiff")) { 
  println("____");
  println(msg.addrPattern());
  println(tag);
  
  println( msg.get(0).intValue() );
  println( msg.get(1).intValue() );
  println( msg.get(2).floatValue() );
  println( msg.get(3).stringValue() );
  
  println();
  }
}
