class Progress{
  PVector loc;
  int rgb;
  float radius;
  float scale;
  float offset;
  float angular;
  
  private float angle = 0;
  Progress(float x, float y, int c, float r, float s, float o, float a){
    loc = new PVector(x, y);
    rgb = c;
    radius = r;
    scale = s;
    offset = o;
    angular = a;
  }
  
  void update(){
    angle += angular;
  }
  
  void draw(){
    float d = radius * 2;
    float d2 = (radius * scale) * 2;
    ellipseMode(CENTER);
    noStroke();
    
    pushMatrix();
    translate(loc.x, loc.y);
    
    fill(rgb);
    ellipse(0, 0, d, d);
    
    PVector v = PVector.fromAngle(angle);
    v.mult(offset);
    translate(v.x, v.y);
    
    fill(0);
    ellipse(0, 0, d2, d2);
    
    popMatrix();
  }
}

Progress[] p;

void setup(){
  fullScreen(P3D);
  p = new Progress[0];
  
  int r = 50;
  int s = (int) (r * 2.2);
  for(int x=r; x<width; x+=s){
    for(int y=r; y<height; y+=s){
      float xp = map(x, 0, width, 0, 1);
      float yp = map(y, 0, height, 0, 1);
      
      int cx = lerpColor(#aaaa00, #00aaaa, xp);
      int cy = lerpColor(#ffff00, #00ffff, yp);
      int c = lerpColor(cx, cy, (xp+yp)/2);
      
      float scale = map(x, 0, width, 0.9, 1);
      float offset = map(y, 0, height, 0, 10);
      
      Progress i = new Progress(x, y, c, r, scale, offset, PI/40);
      p = (Progress[]) append(p, i);
    }
  }  
}

void draw(){
  background(0);
  
  for(Progress i : p){
    i.update();
    i.draw();
  }
}