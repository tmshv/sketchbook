import processing.pdf.*;

// Look also: http://misha.studio/snowflaker/
// Look also: https://www.openprocessing.org/sketch/396759

PGraphicsPDF pdf;

void setup() {
  fullScreen();
  //background(0);

  //pg = createGraphics(200, 200);
  pdf = (PGraphicsPDF) beginRecord(PDF, "sf.pdf");
  
  frameRate(4);
}

void draw() {
  background(255, 255, 255);

  int s = frameCount;
  for (int i=0; i < 1; i ++) {
    render(s ++);
    pdf.nextPage();
  }
}

void render(int seed) {
  background(255, 255, 255);

  int length = 20;

  int step = length * 4;
  int s = seed;
  for (int x=0; x<=width; x+=step) {
    for (int y=0; y<=height; y+=step) {
      resetMatrix();
      translate(x, y);
      drawSnowflake(s, length);
      s++;
    }
  }
}

void mousePressed() {
  endRecord();
  exit();
}

void drawSnowflake(int seed, float length) {
  stroke(100, 100, 100);
  noFill();

  for (int i=0; i<6; i++) {
    randomSeed(seed);
    pushMatrix();
    rotate(i * (PI / 3));

    float x = 0;
    float y = length;
    line(0, 0, x, y);

    int n = (int) random(3, 5);
    for (int j=0; j<n; j++) {
      float r = random(0, 1);
      float l = length * getBranchLength(r);

      pushMatrix();
      translate(0, length * r);
      rotate(PI / 4);
      line(0, 0, 0, l);

      rotate(- PI / 4);
      rotate(- PI / 4);
      line(0, 0, 0, l);
      popMatrix();
    }

    popMatrix();
  }
}

float getBranchLength(float r) {  
  int type = (int) random(0, 3);
  //int type = 1;
  switch(type) {
  case 0:
    return random(0, 1);

  case 1:
    return r * random(0, 1) * random(.5, 1);

  case 2:
    return r * random(0, 1);
  }

  return 0;
}