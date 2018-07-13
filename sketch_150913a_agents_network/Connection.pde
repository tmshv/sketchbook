class Connection{
  Agent a;
  Agent b;
  
  Connection(Agent a, Agent b){
    this.a = a;
    this.b = b;
  }
  
  void update(){
    //steer(a, b, 1);
    steer(a, b, -1.1);
    
    //steer(b, a, 1);
    steer(b, a, -1.1);  
  }
  
  void draw(){
    noFill();
    stroke(0);
    //stroke(0, 95);
    //stroke(0, 2);
    line(
      a.location.x, a.location.y,
      b.location.x, b.location.y
    );
  }
  
  private void steer(Agent a, Agent b, float s){
    PVector v = a.seek(b.location);
    v.limit(s);
    a.force(v);
  }
}