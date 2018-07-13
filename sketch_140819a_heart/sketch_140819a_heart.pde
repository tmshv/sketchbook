import controlP5.*;

/*
more info:
http://habrahabr.ru/post/169219/
*/
int radius = 200;
int n = 300;
float m = 0.5;
  
ControlP5 gui;

void setup(){
  int pos = 10;
  gui = new ControlP5(this);
  gui.addSlider("radius")
     .setPosition(10, pos)
     .setRange(10, 255)
     .setValue(200)
     ;
  pos += 20;
  gui.addSlider("n")
     .setPosition(10, pos)
     .setRange(3, 360)
     .setValue(100)
     ;
  pos += 20;
  gui.addSlider("m")
     .setPosition(10, pos)
     .setRange(0, 2)
     .setValue(0.5)
     ;
  pos += 20;
  
  size(500, 500);
}

void draw(){
  pushMatrix();
  translate(width/2, height/2);
  scale(1, -0.7);
  
  float a = TWO_PI / n;
  beginShape();
  float t = 0;
  for(int i=0; i<n; i++){
    float x = cos(t) * radius;  
    float y = (sin(t) + pow(abs(cos(t)), m)) * radius;
    vertex(x, y);
    t += a;
  }
  endShape(CLOSE);
  popMatrix();
}
