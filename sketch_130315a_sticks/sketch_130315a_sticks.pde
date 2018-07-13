PVector a = new PVector();
PVector b = new PVector();

int radius = 35;

void setup(){
  size(500, 500);
  a.x = width / 2;
  a.y = height / 2;
  b.x = width / 2;
  b.y = height / 2;
  noCursor();
}

void draw(){
  background(204);
  noStroke();
  fill(255);
  a.x = mouseX;
  a.y = mouseY;
  ellipseMode(CENTER);
  ellipse(a.x, a.y, radius*2, radius*2);
  ellipse(b.x, b.y, radius*2, radius*2);
  
  float maxDist = (float) width/5;
  float d = dist(a.x, a.y, b.x, b.y);
  float r = 1 / (d / maxDist);
  r = min(r, 1);
  
  float q;
  q = atan2(a.y-b.y, a.x-b.x);
  PVector a1 = new PVector(a.x+cos(q+HALF_PI)*radius, a.y+sin(q+HALF_PI)*radius);
  PVector a2 = new PVector(a.x+cos(q-HALF_PI)*radius, a.y+sin(q-HALF_PI)*radius);
  
  PVector b1 = new PVector(b.x+cos(q+HALF_PI)*radius, b.y+sin(q+HALF_PI)*radius);
  PVector b2 = new PVector(b.x+cos(q-HALF_PI)*radius, b.y+sin(q-HALF_PI)*radius);
  
  PVector c = new PVector((a.x+b.x)/2, (a.y+b.y)/2);
  PVector c1 = new PVector(c.x+cos(q+HALF_PI)*radius*r, c.y+sin(q+HALF_PI)*radius*r);
  PVector c2 = new PVector(c.x+cos(q-HALF_PI)*radius*r, c.y+sin(q-HALF_PI)*radius*r);

  beginShape();
  int steps = 10;
  for (int i = 0; i <= steps; i++) {
    float t = i / float(steps);
    float x = bezierPoint(a1.x, c1.x, c1.x, b1.x, t);
    float y = bezierPoint(a1.y, c1.y, c1.y, b1.y, t);
    vertex(x, y);
  }
  for (int i = 0; i <=steps; i++) {
    float t = i / float(steps);
    float x = bezierPoint(b2.x, c2.x, c2.x, a2.x, t);
    float y = bezierPoint(b2.y, c2.y, c2.y, a2.y, t);
    vertex(x, y);
  }
  endShape();
  
//  fill(0);
//  rect(c.x, c.y, 2, 2);
//  rect(c1.x, c1.y, 2, 2);
//  rect(c2.x, c2.y, 2, 2);
  text("move your mouse and click", 2, 12);
  pointer(a);
  pointer(b);  
}

void pointer(PVector c){
  fill(0);
  int s = 3;
  stroke(0);
  line(c.x-s, c.y, c.x+s, c.y);
  line(c.x, c.y-s, c.x, c.y+s);  
}

void mousePressed(){
  b.x = mouseX;
  b.y = mouseY;
}
