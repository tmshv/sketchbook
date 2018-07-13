void setup() {
  size(500, 500);
  noLoop();
}

void keyPressed(){
  
}

void draw() {
  background(255);

  blendMode(DIFFERENCE);


  noStroke();
  //noFill();

  //translate(width/2, height/2);

  float m = 120;
  float rm = row(m); 
  float xm = m / 2;
  
  int yi = 0;
  translate(m/2, m/2);
  for (int y=0; y<height; y += m) {
    pushMatrix();
    if(yi % 2 == 0) {
      translate(xm, 0);
    }
    for (int x=0; x<width; x += m) {
      float r = 100;
      float r2 = random(10, 30);
      float s = random(0.1, 0.3);//.1;
      //float r2 = map(mouseX, 0, width, 0, 200);
      //float s = map(mouseY, 0, height, .1, 5);
      int n = 30;

      pushMatrix();
      translate(x, y);
      drawFlower(r, r2, s, n);    
      popMatrix();
    }
    popMatrix();
    yi ++;
  }
  
  //saveFrame("###.png");
  //exit();
}

float row(float a){
  return a * sqrt(3) / 2;
}

void drawFlower(float r, float r2, float s, int n) {
  float as = TWO_PI / (float) n;
  float a = 0;
  for (int i=0; i<n; i++) {
    pushMatrix();
    float x = cos(a) * r2;
    float y = sin(a) * r2;

    translate(x, y);
    rotate(a);

    circle(0, 0, r, s);
    a += as;

    popMatrix();
  }
}

void circle(float x, float y, float r, float scale) {
  ellipse(x, y, r * scale, r);
}
