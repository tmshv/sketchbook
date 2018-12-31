void setup() {
  pixelDensity(2);
  size(800, 800);
  //size(1850, 2650);
  
  //noLoop();
}

void draw () {
  background(255);

  int s = 40;

  for (int x=0; x<width; x+=s) {
    for (int y=0; y<height; y+=s) {
      pushMatrix();
      translate(x, y);
      drawAgent(s, s);
      popMatrix();
    }
  }
  
  //saveFrame("###.jpg");
}

void drawAgent(int w, int h){
  //int w2 = w / 2;
  int w2 = (int) random(w);

  noStroke();
  fill(255, 0, 0);
  
  beginShape();
  vertex(w2, 0);
  vertex(w, 0);
  vertex(w2, h);
  vertex(0, h);
  endShape(CLOSE);
}
