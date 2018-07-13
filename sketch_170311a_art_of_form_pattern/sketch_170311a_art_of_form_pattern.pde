int seed = 0;
void setup() {
  size(600, 600);
  noStroke();
}

void draw() {
  randomSeed(seed);
  
  background(255);
  //translate(width/2, height/2);

  int s = 20;
  float r = map(mouseX, 0, width, 0, 1);

  int i = 0;
  for (int x=0; x<width; x+=s) {
    for (int y=0; y<height; y+=s) {
      pushMatrix();
      translate(x, y);

      int c = (int) random(0, 3);

      r = random(0, 1);

      if (c == 0) drawCell1(s, r, i % 2 == 0);
      if (c == 1) drawCell2(s, r, i % 2 == 0);
      if (c == 2) drawCell3(s, r, i % 2 == 0);

      popMatrix();

      i++;
    }
    i++;
  }
}

void drawCell1(int size, float s, boolean isWhite) {
  int s2 = size / 2;
  pushMatrix();
  translate(s2, s2);    

  fill(isWhite ? 255 : 0);
  rectMode(CENTER);
  rect(0, 0, size, size);

  float r = size * s;
  fill(isWhite ? 0 : 255);
  //ellipseMode(CORNER);
  ellipse(0, 0, r, r);
  popMatrix();
}

void drawCell2(int size, float s, boolean isWhite) {
  drawCellWithRectCenter(size, s, isWhite, 0);
}

void drawCell3(int size, float s, boolean isWhite) {
  drawCellWithRectCenter(size, s, isWhite, PI / 4);
}

void drawCellWithRectCenter(int size, float s, boolean isWhite, float rotate) {
  int s2 = size / 2;
  pushMatrix();
  translate(s2, s2);    

  fill(isWhite ? 255 : 0);
  rectMode(CENTER);
  rect(0, 0, size, size);

  fill(isWhite ? 0 : 255);
  ellipse(0, 0, size, size);

  float r = sizeOfRadius(size) * s;
  rotate(rotate);
  fill(isWhite ? 255 : 0);
  rectMode(CENTER);
  rect(0, 0, r, r);

  popMatrix();
}

float sizeOfRadius(float r) {
  return sqrt((r * r) / 2);
}

void keyPressed(){
  if(key == 's') saveFrame("###.png");
}

void mousePressed(){
  seed ++;
}