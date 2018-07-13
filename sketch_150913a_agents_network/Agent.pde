class Agent{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  
  Agent(float x, float y, float s){
    location = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    maxSpeed = s;
  }
  
  void update(){
    velocity.add(acceleration);
    
    velocity.limit(maxSpeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void force(PVector f){
    acceleration.add(f);
  }
  
  PVector seek(PVector target){
    //desired
    PVector steer = PVector.sub(target, location);
    steer.normalize();
    
    //steer
    steer.sub(velocity);
    return steer;
  }
  
  Connection connect(Agent a){
    return new Connection(this, a);
  }
  
  float distanceTo(Agent a){
    return this.location.dist(a.location);
  }
  
  void draw(){
    //fill(255, 255, 0);
    fill(0);
    noStroke();
    pushMatrix();
    translate(location.x, location.y);
    ellipseMode(CENTER);
    ellipse(0, 0, 4, 4);
    popMatrix();
  }
}