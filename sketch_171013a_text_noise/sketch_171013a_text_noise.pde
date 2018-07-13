float noiseScale = 0.005;
PGraphics s;
PFont font;

int fontSize = 150;

void setup() {
  pixelDensity(2);
  //size(2500, 3500);
  size(600, 600);

  font = createFont("InputMonoCompressed-Light.ttf", fontSize);
  s = createGraphics(150, 150);

  //noLoop();
}

void draw() {
  //if (mousePressed) {
    background(220);
    drawFrame();
    //saveFrame("###.jpg");
  //}
}

void drawFrame() {
  randomSeed(1);
  noiseScale = map(mouseX, 0, width, 0, 0.075);
  
  int cellSize = 150;
  for (int x=0; x<width; x+=cellSize) {
    for (int y=0; y<height; y+=cellSize) {
      pushMatrix();
      translate(x, y);
      randomRotate(cellSize);

      //noiseScale = random(0.015, 0.075);
      float mult = 15;

      createSample(randomText());
      drawCell(noiseScale, mult);

      popMatrix();
    }
  }
}

String randomText() {
  String[] texts = {"GF", "BD", "ML", "RT", "LV", "KS", "17"};
  int index = (int) random(0, texts.length);
  return texts[index];
}

void createSample(String text) {
  s.beginDraw();
  s.background(0);
  s.fill(255);
  s.textSize(fontSize);
  s.textFont(font);
  s.text(text, 10, 120);
  s.endDraw();
}

void randomRotate(int cellSize) {
  float r = random(1);

  if (r < 0.25) {
    return;
  }

  if (r < 0.5) {
    translate(cellSize, 0);
    rotate(HALF_PI);
    return;
  }

  if (r < 0.75) {
    translate(0, cellSize);
    rotate(-HALF_PI);
    return;
  }

  translate(cellSize, cellSize);
  scale(-1, -1);
}

void drawCell(float noiseScale, float mult) {
  for (int x=0; x<s.width; x++) {
    for (int y=0; y<s.height; y++) {
      int c = s.get(x, y);
      if (c == -1) {
        float value = noise(x*noiseScale, y*noiseScale);
        PVector v = PVector.fromAngle(value * TWO_PI);
        v.mult(mult);

        stroke(255);
        noStroke();
        fill(255);
        rect(x + v.x, y + v.y, 2, 2);
      }
    }
  }
}