float angleStep = 137.5;
float radiusStep = 0.2;

void setup(){
  size(600, 600);
}

void draw(){
  float radius = 10;
  float angle = 0;

  translate(width/2, height/2);
  ellipseMode(CENTER);
  background(0);
  
  noStroke();
  fill(200, 200, 0);  
  radiusStep = map(mouseX, 0, width, .1, 1);
  float s = map(mouseY, 0, height, 3, 40);
  
  for(int i=0; i<1000; i++){
    float x = cos(angle) * radius;
    float y = sin(angle) * radius;
    ellipse(x, y, s, s);
    
    angle += radians(angleStep);
    radius += radiusStep;  
  }
}