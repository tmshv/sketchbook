void setup() {
  //size(2480, 3507);
  
  size(800, 800);
  pixelDensity(2);
}

void draw() {
  background(255);
  randomSeed(0);

  float m = 100;
  drawPattern(m, 0);
}

void drawPattern(float m, float startAngle) {
  float xm = m / 2;

  int yi = 0;

  for (int y=0; y<height; y += m) {
    pushMatrix();

    if (yi % 2 == 0) {
      translate(xm, 0);
    }

    for (int x=0; x<width; x += m) {
      pushMatrix();
      translate(x, y);
      rotate(startAngle);

      float am = m * 1;
      int d = (int) random(0, 3);
      if (d == 0) {
        drawAgent0(am);
      } else if (d == 1) {
        drawAgent1(am);
      } else if (d == 2) {
        drawAgent2(am);
      }

      popMatrix();
    }

    popMatrix();
    yi ++;
  }
}

void drawAgent0(float m) {
  float h = m/2;
  pushMatrix();
  translate(0, -h);
  rotate(PI / 3);
  drawAgent(m);
  popMatrix();
}

void drawAgent1(float m) {
  float h = m/2;
  pushMatrix();
  translate(h, th(h));
  rotate(PI);
  drawAgent(m);
  popMatrix();
}

void drawAgent2(float m) {
  float h = m/2;
  pushMatrix();
  translate(-h, th(h));
  rotate(-PI/3);
  drawAgent(m);
  popMatrix();
}

void drawAgent(float radius) {
  int n = (int) random(3, 8);

  float a = 0;
  float step = radians((60 - a) / n);
  float angle = radians(a);
  for (int i=0; i<n; i++) { 
    PVector p1 = PVector
      .fromAngle(angle)
      .mult(radius);

    angle += step;    

    PVector p2 = PVector
      .fromAngle(angle)
      .mult(radius);

    float alpha = random(0.3, 1);

    noStroke();
    fill(0, alpha * 255);
    triangle(0, 0, p1.x, p1.y, p2.x, p2.y);
  }
}

void keyPressed(){
  saveFrame("f###.jpg");
}

float th(float x) {
  return sin(PI/3) * x;
}
