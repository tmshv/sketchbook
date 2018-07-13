PImage img;

void setup(){
  size(800, 533);
  img = loadImage("image.jpg");
  image(img, 0, 0);
  frameRate(20);
}

void draw(){
  int s = 10;
  int n = (int) (width / s);
  for(int i=0; i<n; i++){
    int pos = (int) random(0, height);
    PImage piece = img.get(0, pos, width, s);
    
    int place_pos = (int) module(random(0, height), s);
    image(piece, 0, place_pos);
  }
}

float module(float value, int module){
  value /= module;
  value = round(value);
  value *= module;
  return value;
}

void mouseReleased(){
  loop();
}

void mousePressed(){
  noLoop();
}
