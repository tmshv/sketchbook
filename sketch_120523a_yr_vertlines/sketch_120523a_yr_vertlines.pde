float h_step = 1;
int h_value = 0;

void setup(){
  colorMode(HSB, 360, 100, 100);
  size(800, 300);
  //h_step = 800 / 360;
//  frameRate(4saveFrame("screen.png");saveFrame("screen.png");saveFrame("screen.png");saveFrame("screen.png");saveFrame("screen.png"););
}

void draw(){
  background(0);
  h_value = 0;
  int step = 1;//width / 360;
  int w = step;//mouseX;
  for(int i=0; i<width; i+=step){
    stroke(readH(), readS(), readV());
//    rect(pos, 0, w, height);
    line(i, 0, i, height);
    h_value += h_step;
  }
}

void mousePressed(){
  saveFrame("screen###.png");    
}

int h_min = 0;
int h_max = 100;

int readH(){
  return int(h_min + random(h_max-h_min));
  //return 0;
}

int readS(){
  return int(90 + random(10));
  //return 100;
}

int readV(){
  return int(90 + random(10));
  //return 100;
}
