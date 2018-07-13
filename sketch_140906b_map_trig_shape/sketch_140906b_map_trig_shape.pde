void setup(){
  size(500, 500);
}

void draw(){
  background(204);
  
  int n = (int) map(mouseX, 0, width, 3, 10);
  float angle = 0;
  float step = 2*PI / (float )n;
  int radius = 100;
  beginShape();
  for(int i=0; i<n; i++){
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    
    vertex(width/2 + x, height/2+y);  
    angle += step;
  }
  endShape(CLOSE);
}
