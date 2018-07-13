void setup(){
  fullScreen();  
}

void draw(){
  if(mousePressed) return;
  
  background(0);
  pushMatrix();  
  translate(width / 2, height / 2);
  
  int n = 1000;
  float r = height * .4;
  
  for(int i=0; i<n; i++){
    float angle = random(0, TWO_PI);
    PVector v = PVector.fromAngle(angle);
    v.mult(random(r));
    
    float m = 2;
    float sd = map(v.mag(), 0, r, 20, 2);
    float s = m + randomGaussian() * sd;
    
    stroke(#aaaa00);
    noFill();
    ellipseMode(CENTER);
    ellipse(v.x, v.y, s, s);
  }
  popMatrix();
}