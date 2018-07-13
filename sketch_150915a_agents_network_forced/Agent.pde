class Agent {
  PVector loc;
  PVector vel;
  PVector acc;
  float mass;
  float damping;
  
  Agent(float x, float y){
    this(x, y, 1, 0.9);
  }
  
  Agent(float x, float y, float mass, float damping){
    this.loc = new PVector(x, y);
    this.vel = new PVector();
    this.acc = new PVector();
    this.mass = mass;
    this.damping = damping;
  }
  
  PVector seek(PVector target){
    return PVector.sub(target, loc);
  }
  
  PVector flee(PVector target){
    return PVector.mult(seek(target), -1);
  }
  
  void force(PVector f){
    acc.add(PVector.div(f, mass));
  }
  
  public void attractGG(Agent theNode) {
    float ramp = 1;
    float strength = -.001;
    float radius = 200;
    float d = PVector.dist(this.loc, theNode.loc);
    if (d > 0) {
      float s = pow(d / radius, 1 / ramp);
      float f = s * 9 * strength * (1 / (s + 1) + ((s - 3) / 4)) / d;
      PVector df = PVector.sub(loc, theNode.loc);
      df.mult(f);

      this.force(df);

      //theNode.velocity.x += df.x;
      //theNode.velocity.y += df.y;
      //theNode.velocity.z += df.z;
    }
  }
  
  void update(){
    vel.add(acc);
    vel.mult(1 - damping);
    
    loc.add(vel);
    acc.mult(0);
  }
  
  void draw(){
    stroke(255, 255, 0);
    strokeWeight(1);
    fill(0);
    ellipseMode(CENTER);
    ellipse(loc.x, loc.y, 6, 6);
  }
}