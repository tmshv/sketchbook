import processing.video.*;
Capture cam;

void setup() {
  frameRate(100);
  size(640, 480);
  cam = new Capture(this, width, height, 100);
}

void captureEvent(Capture cam) {
  cam.read();
}

void draw() {
  cam.loadPixels();
  fillWithCircles(cam.pixels, 25);
//  saveFrame("2/####.png");
}

void fillWithCircles(color[] pixels, int diam) {
  background(0x000000);
  noStroke();
  
  int columns = ceil(width / diam);
  int rows = ceil(height / diam);

  for (int x=0; x<columns; x++) {
    for (int y=0; y<rows; y++) {
      int coord_x = x*diam;
      int coord_y = y*diam;
      int i = coord_x + coord_y*width;
      color pixel = pixels[i];

      fill(getFilteredColor(pixel));
      int pos_x = coord_x + diam/2;
      int pos_y = coord_y + diam/2;
      ellipse(pos_x, pos_y, diam, diam);
    }
  }
}

color getFilteredColor(color source) {
  colorMode(RGB, 0xff, 0xff, 0xff);
  float r = red(source);
  float g = green(source);
  float b = blue(source);
  r *= 3;
  g *= 3;
  b *= 3;
  r = constrain(r, 0, 0xff);
  g = constrain(g, 0, 0xff);
  b = constrain(b, 0, 0xff);
  color lighted = color(r, g, b);
  
  colorMode(HSB, 360, 100, 100);
  float h = hue(lighted);
  float s = saturation(lighted);
  float l = brightness(lighted);
  
  float ratio = (float)mouseY/height;
  float a = 0 + (ratio * 360); //from 1 to 10
  h += a;
  return color(h, s, l);
}

