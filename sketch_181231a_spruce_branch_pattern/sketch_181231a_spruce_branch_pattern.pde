void setup() {
  pixelDensity(2);
  //size(800, 800);
  size(1850, 2650);
  //size(2650, 1850);
  noLoop();
}

void draw() {
  background(255);
  randomSeed(0);

  //translate(width/2, height/2);

  for (int x=0; x<width; x+= 23) {
    pushMatrix();
    translate(x, 0);
    rotate(HALF_PI);

    drawBranch(height, 0.0025, 20, 30);

    popMatrix();
  }
  
  saveFrame("####.jpg");
}

void drawBranch(float length, float density, float needleLengthMin, float needleLengthMax) {
  float step = length * density;

  for (int x=0; x<length; x+=step) {
    pushMatrix();
    float needleLength = random(needleLengthMin, needleLengthMax);

    translate(x, 0);
    drawNeedle(needleLength);

    popMatrix();
  }
}

void drawNeedle(float needleLength) {
  float strokeAlpha = 100;
  strokeWeight(2);
  stroke(0, 0, 0, strokeAlpha);
  noFill();

  float needleAngleDeviation = radians(random(-45, 45));

  pushMatrix();
  rotate(needleAngleDeviation);

  line(0, 0, needleLength, 0);

  popMatrix();
}

float row(float a) {
  return a * sqrt(3) / 2;
}
