// http://habrahabr.ru/post/251419/

void setup(){
  size(800, 600);
}

void draw(){
  background(0);
  int n = 250;
  colorMode(RGB, 255, 255, 255, 100);  
  int alpha = 2;
  for(int i=0; i<n; i++){
    int pt1 = (int) random(width);
    int pt2 = (int) random(pt1, width);
    int pb1 = (int) random(width);
    int pb2 = (int) random(pb1, width);
    
    fill(255, 255, 255, alpha);
    noStroke();
    beginShape();
    vertex(pt1, 0);
    vertex(pt2, 0);
    vertex(pb2, height);
    vertex(pb1, height);
    endShape(CLOSE);
  }
  
  // noLoop();
}
