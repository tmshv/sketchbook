void setup(){
  size(600, 600);
  smooth();
  background(0);
}

void mousePressed(){
  background(0);
}

void draw(){
  background(0);
  //noStroke();
  //fill(20, 15);
  //rect(0, 0, width, height);
  
  int s = 30;
  for(int x=0; x<=width; x += s){
    for(int y=0; y<=height; y += s){
      float f = frameCount / map(mouseX, 0, width, 100.0, 100000.0);

      Obj v = new Obj(x, y);
      v.direct(map(noise(x*f, y*f), 0, 1, 0, TWO_PI));
      v.velocity.setMag(map(noise(frameCount/100.0), 0, 1, 5, s*.9));
      v.draw();
    }
  }
}

class Obj {
  PVector location;
  PVector velocity;
  
  Obj(float x, float y){
    location = new PVector(x, y);
    velocity = new PVector(10, 0);
  }
  
  void direct(float angle){
    velocity.rotate(angle);
  }
  
  void draw(){
    pushMatrix();
    translate(location.x, location.y);
    rotate(atan2(velocity.y, velocity.x));
    
    noFill();
    stroke(200, 200, 0);
    strokeWeight(1);
    line(0, 0, velocity.mag(), 0);
    beginShape();
    vertex(velocity.mag() - 5, -3);
    vertex(velocity.mag(), 0);
    vertex(velocity.mag() - 5, 3);
    endShape();
    
    popMatrix();
  }
}