void setup(){
  size(500, 500);
}

void draw(){
  if(mousePressed){
    colorMode(RGB, 255, 255, 255);
    background(204);
    
    float h = random(360);
    int num = 50;
    
    float[] hues = getHue(h, num);
    for(float hue : hues){
      colorMode(HSB, 360, 100, 100);
      ellipseMode(CENTER);
      noStroke();
      
      int x = (int) random(width);
      int y = (int) random(height);
      
      fill(hue, random(50, 100), random(50, 100));
      fill(h, random(100), random(50, 75));
      //fill(hue, 100, 100);
      ellipse(x, y, 150, 150);
    }
  }
}

float[] getHue(float start, int num){
  float[] out = new float[num];
  float angle = start;
  for(int i=0; i<num; i++){
    out[i] = angle;
    angle += 137.5;
    angle %= 360; 
  }
  return out;
}