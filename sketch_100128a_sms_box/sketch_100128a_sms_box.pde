import sms.*;

void setup() {
  size(640, 640, P3D);
  fill(204);
}

void draw() {
  lights();
  background(0x000000);
  
  camera(0.0, 0.0, 200.0,
         0.0, 0.0, 0.0,
         0.0, 1.0, 0.0);
 
  int[] sms = Unimotion.getSMSArray();
  int x = sms[0];
  int y = sms[1];
  int z = sms[2];
  
  rotateX(y/300.0);
  rotateZ(-x/300.0);
  
  noStroke();
  box(90);
  stroke(255);
  line(-100, 0, 0, 100, 0, 0);
  line(0, -100, 0, 0, 100, 0);
  line(0, 0, -100, 0, 0, 100);
}
