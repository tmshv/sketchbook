int sizeX = 5;
int sizeY = 5;

void setup() {
  //size(2480, 3507);

  size(800, 800);
  pixelDensity(2);

  noLoop();
}

void draw() {
  randomSeed(0);
  background(255);

  for (int x=0; x<width; x += sizeX) {
    for (int y=0; y<height; y += sizeY) {
      pushMatrix();
      translate(x, y);

      boolean r = random(1) < 0.5;
      if (r) {
        drawAgent1();
      } else {
        drawAgent2();
      }
      popMatrix();
    }
  }

  saveFrame("f###.jpg");
}

void drawAgent1() {
  stroke(0);
  noFill();
  line(0, 0, sizeX, sizeY);
}

void drawAgent2() {
  stroke(0);
  noFill();
  line(sizeX, 0, 0, sizeY);
}