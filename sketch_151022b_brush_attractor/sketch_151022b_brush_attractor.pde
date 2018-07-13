class Attractor{
  PVector loc;
  float r;
  float mass;
  
  PVector attract(PVector v, float maxForce){
    PVector diff = PVector.sub(loc, v);
    float length = diff.mag();
    if(length < r){
      float force = (1 * mass) / (length * length) * 100;
      force = constrain(force, 0, maxForce);
      diff.normalize();
      diff.mult(force);
      return PVector.add(v, diff);
    }else{
      return null;
    }
  }
}

class Brush{
  PVector loc;
  float r;
  //float thickness;
  
  Brush(float x, float y, float radius){
    loc = new PVector(x, y);
    r = radius;
  }
  
  void locate(float x, float y){
    loc.x = x;
    loc.y = y;
  }
  
  void changeRadius(float delta){
    r += delta;
    r = constrain(r, 10, 400);
  }
  
  void draw(){
      float s = r * 2;
      stroke(#dddd00);
      noFill();
      ellipseMode(CENTER);
      ellipse(loc.x, loc.y, s, s);
  }
  
  Attractor createAttractor(){
    Attractor a = new Attractor();
    a.loc = loc.get();
    a.r = r;
    a.mass = 100;
    return a;
  }
}

PVector[] points;

Brush brush;

void setup(){
  fullScreen(P2D);
  brush = new Brush(0, 0, 50);
  points = new PVector[0];
  generate(width/2, height/2, height * .6);
}

void draw(){
  background(0);
  
  brush.locate(mouseX, mouseY);
  brush.draw();
  
  Attractor a = brush.createAttractor();
  
  //if(mousePressed){
  //  brush(mouseX, mouseY);
  //}
    
  strokeCap(SQUARE);
  
  float cx = width/2;
  float cy = height/2;
  for(PVector p : points){
    float r = dist(p.x, p.y, cx, cy);
    float angle = atan2((p.y-cy), (p.x-cx)); 
    angle += p.z;
    p.x = cx + cos(angle) * r;
    p.y = cy + sin(angle) * r;
  }
  
  for(PVector p : points){
    PVector v = a.attract(p, brush.r);
    if(v == null){
      strokeWeight(1);
      stroke(#cccccc);
      point(p.x, p.y);
    }else{
      float d = dist(p.x, p.y, v.x, v.y);
      int c = #aaaa00;//lerpColor(#111100, #ffff00, map(d, 0, brush.r*2, 1, 0));
      strokeWeight(map(d, 0, brush.r*2, 1, 5));
      stroke(c);
      line(p.x, p.y, v.x, v.y);
    }
  }
  
  //translate(mouseX, mouseY);
  //ellipseMode(CENTER);
  
  //float d = size * 2;
  //noFill();
  //stroke(#aaaa00);
  //ellipse(0, 0, d, d);
}

void mouseWheel(MouseEvent e){
  float wheel = e.getCount(); 
  brush.changeRadius(wheel);
}

void keyPressed(){
  saveFrame("brush_attractor-###.jpg");  
}

void generate(float cx, float cy, float radius){
 int n = 10000;
 for(int i=0; i<n; i++){
   float v = map(randomGaussian(), -5, 5, 0, 1);
   float r = v * radius;
   float angle = map(i, 0, n, 0, TWO_PI) + frameCount * .001;
   float x = cx + cos(angle) * r;
   float y = cy + sin(angle) * r;
   float angular = map(r, 0, radius, .001, .005);
   if(prob(.025)) angular += random(0.005);
   points = (PVector[]) append(points, new PVector(x, y, angular));
 }
}

boolean prob(float v){
  return v > random(1);  
}