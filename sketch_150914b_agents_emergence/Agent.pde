class Agent {
  PVector loc;
  PVector velocity;
  
  Agent(float x, float y){
    loc = new PVector(x, y);
    velocity = PVector.random2D();
  }
  
  void seek(PVector target){
    velocity = PVector.sub(target, loc);
    velocity.normalize();
  }
  
  void update(){
    loc.add(velocity);
  }
}