class Link {
  Agent a1;
  Agent a2;
  
  float length;
  float k;
  
  Link(Agent a1, Agent a2) {
    this(a1, a2, 100, 1);
  }
  
  Link(Agent a1, Agent a2, float length, float k){
    this.a1 = a1;
    this.a2 = a2;
    this.length = length;
    this.k = k;
  }
  
  //void update(){
  //  PVector force = PVector.sub(a2.loc, a1.loc);
  //  force.normalize();
  //  force.mult(length);
  
  //  force.add(a1.loc);    
  //  force.sub(a2.loc);
    
  //  force.mult(stifness);
  //  force.mult(1 - dampling);
  //  force.mult(.5);
    
  //  a2.loc.add(force);
  //  force.mult(-1);
  //  a1.loc.add(force);
  //}
  
  void draw(){
    noFill();
    stroke(200, 200, 0);
    strokeWeight(3);
    line(a1.loc.x, a1.loc.y, a2.loc.x, a2.loc.y);
    
    a1.draw();
    a2.draw();
  }
}