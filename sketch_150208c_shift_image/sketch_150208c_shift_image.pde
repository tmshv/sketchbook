// import controlP5.*;

PVector coord = new PVector(30, 300);
PImage img;
int backgroundColor = 60;

void setup(){
  size(700, 700);
  
  generate();
  loadPixels();
  
  img = new PImage(width, height);
  img.loadPixels();
  img.pixels = pixels;
  img.updatePixels();
  
  frameRate(20);
}

void draw(){
  background(backgroundColor);
  
  float d = map(mouseX, 0, width, 0, 200);
  int h = (int) map(mouseY, 0, height, 1, 10);
  
  int pos = 0;
  int n = (int) (height / h);
  for(int i=0; i<n; i++){
    PImage line = img.get(0, pos, width, h);
    image(line, random(d), pos);
    pos += (int) h;
  }
}

void mousePressed(){
  coord = new PVector(mouseX, mouseY);
}

void generate(){
  background(backgroundColor);
  
  for(int i=0; i<100; i++){
    
    translate(random(width), random(height));
    rotate(random(TWO_PI));
    
    float size = random(10, map(i, 0, 100, 10, 200));
    float amt = size / 200;
    color b = lerpColor(
      color(100, 100, 0),
      color(255, 20, 200),
      amt
    );
    
    fill(b);
    textSize((int) size);
    text("HELLO", 0, 0);
    resetMatrix();
  }
}
