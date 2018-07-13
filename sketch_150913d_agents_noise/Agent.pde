class Agent{
  PVector location;
  PVector previousLocation;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  
  Agent(float x, float y, float s){
    location = new PVector(x, y);
    previousLocation = location.get();
    velocity = new PVector();
    acceleration = new PVector();
    maxSpeed = s;
  }
  
  void update(){
    float scale = .01;
    float angle = map(noise(location.x * scale, location.y * scale), 0, 1, 0, TWO_PI);
    force(PVector.fromAngle(angle));
    
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    location.add(velocity);
    
    acceleration.mult(0);
    previousLocation.set(location);
  }
  
  void force(PVector f){
    acceleration.add(f);
  }
  
  void draw(){
    noFill();
    stroke(0 , 5);
    line(previousLocation.x, previousLocation.y, location.x, location.y);
  }
}