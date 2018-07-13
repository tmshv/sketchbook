void setup(){
  size(500, 500);
//  frameRate(2);
  noFill();
//  noSmooth();
  for(int i=0; i<100; i++){
    draw();
  }
}

void draw(){
  int x1 = (int) random(-100, width+100);
  int y1 = (int) random(-100, height+100);
  int x2 = (int) random(-100, width+100);
  int y2 = (int) random(-100, height+100);
  int x3 = (int) random(-100, width+100);
  int y3 = (int) random(-100, height+100);
  int x4 = (int) random(-100, width+100);
  int y4 = (int) random(-100, height+100);
  
  strokeWeight(3);
  stroke((int)random(0, 100), 100, 100);
  bezier(x1, y1, x2, y2, x3, y3, x4, y4);
  
  strokeWeight(1);
  stroke(random(200, 255));
  bezier(x1, y1, x2, y2, x3, y3, x4, y4);
}
