float wheel = 0;
float size = 100;

PVector[] points;

void setup(){
  size(600, 600);
  
  points = new PVector[0];
}

void draw(){
  background(0);
  text(str(wheel), 10, 15);
  
  if(mousePressed){
    brush(mouseX, mouseY);
  }
  
  stroke(255, 200);
  for(PVector p : points){
    point(p.x, p.y);    
  }
  
  translate(mouseX, mouseY);
  ellipseMode(CENTER);
  
  size += wheel;
  float d = size * 2;
  noFill();
  stroke(#aaaa00);
  ellipse(0, 0, d, d);
  
  wheel = 0;
}

void mouseWheel(MouseEvent e){
  wheel = e.getCount();
}

void brush(float cx, float cy){
  int n = 100;
  float radius = size;
  for(int i=0; i<n; i++){
    float v = map(randomGaussian(), -5, 5, 0, 1);
    float r = v * radius;
    float angle = map(i, 0, n, 0, TWO_PI) + frameCount * .001;
    float x = cx + cos(angle) * r;
    float y = cy + sin(angle) * r;
    points = (PVector[]) append(points, new PVector(x, y));
  }
}