Bug b;

void setup(){
 size(500,500); 
  b = new Bug();
}

void draw(){
  background(0);
  b.fly();
  b.move();
  b.display();
  
}