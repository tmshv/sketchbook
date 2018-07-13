class Particle{
  PVector loc;
  PVector acc;
  PVector vel;
  float mass;
  
  Particle(float x, float y, float m){
    loc = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    mass = m;
  }
  
  void update(){
      vel.add(acc);
      vel.limit(2);
      loc.add(vel);
      acc.mult(0);
  }
  
  void force(PVector f){
    acc.add(f.copy().div(mass));  
  }
  
  void draw(){
    pushMatrix();
    translate(loc.x, loc.y);
    ellipseMode(CENTER);
    float s = map(mass, 0, 100000, 3, 100);
    noFill();
    //stroke(#aaaa00, 50);
    strokeWeight(3); stroke(#aaaa00);
    point(0, 0);
    //ellipse(0, 0, s, s);
    popMatrix();
  }
}

//Particle p1;
//Particle p2;
//float G =  6.67428 * pow(10, -11);
//float scale = 1000000000;

Particle[] particles;

float G =  .01;
float scale = 1;

void setup(){
  fullScreen();
  background(0);
  
  particles = new Particle[1];
  particles[0] = new Particle(width/2, height/2, 10000);
  
  int n = 500;
  for(int i=0; i<n; i++){
    Particle p = new Particle(random(width), random(height), random(5, 50));
    p.vel.set(PVector.fromAngle(random(0, TWO_PI)));
    
    particles = (Particle[]) append(particles, p);
  }
  
  //p1 = new Particle(width/3, height/3, 10);
  //p1.vel.set(2, 10);
  //p2 = new Particle(width/2, height/2, 10000);
}

void draw(){
  background(0);
  
  for(Particle p1 : particles){
    for(Particle p2 : particles){
      if(p1 != p2){
        PVector f = gravity(p1, p2).mult(scale);
        p1.force(f);
        f.mult(-1);
        p2.force(f);      
      }
    }
  }
  
  for(Particle p : particles){
    p.update();
    p.draw();
  }
}

PVector gravity(Particle p1, Particle p2){
  float d = p1.loc.dist(p2.loc);
  PVector v = PVector.sub(p2.loc, p1.loc);
  float r2 = v.magSq();
  float force = G * (p1.mass * p2.mass) / r2;
  
  v.normalize();
  v.mult(force);
  return v;
}