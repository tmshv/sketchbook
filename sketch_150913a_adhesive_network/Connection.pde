class Connection{
  Agent a;
  Agent b;
  
  float radius = 15;
  
  Connection(Agent a, Agent b){
    this.a = a;
    this.b = b;
  }
  
  void update(){
    steer(a, b, 1);
    steer(a, b, -1.1);
    
    steer(b, a, 1);
    steer(b, a, -1.1);  
  }
  
  void draw(){
    stick(a.location, b.location);
  }
  
  void stick(PVector a, PVector b){
    noStroke();
    fill(255);
    
    ellipseMode(CENTER);
    ellipse(a.x, a.y, radius*2, radius*2);
    ellipse(b.x, b.y, radius*2, radius*2);
    
    float maxDist = 25;
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
  }
  
  private void steer(Agent a, Agent b, float s){
    PVector v = a.seek(b.location);
    v.limit(s);
    a.force(v);
  }
}