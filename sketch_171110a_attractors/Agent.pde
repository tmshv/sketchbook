class Agent {
  PVector loc;
  PVector velocity;
  
  float damp = 0.0002; // remember a very small amount of the last direction
  float accel = 64;
  Agent(float x, float y){
    loc = new PVector(x, y);
    
    
    //velocity = PVector.random2D();
    velocity = new PVector(
       accel * random(-1, 1),
       accel * random(-1, 1)
    );
  }
  
  void seek(PVector target){
    PVector desire = PVector.sub(target, loc);
    desire.normalize();
    desire.mult(this.accel);
    
    velocity.add(desire);
  }
  
  void update(){
    loc.add(velocity);
    
    this.velocity.mult(this.damp);
  }
}