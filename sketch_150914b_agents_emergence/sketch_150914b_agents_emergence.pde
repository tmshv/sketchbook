//look also: www.patrickgunderson.com/#interactive/5

ArrayList<Agent> agents = new ArrayList<Agent>();

void setup(){
  size(600, 600);
  
  for(int i=0; i<100; i++) {
   float x = random(width);
   float y = random(height);
   agents.add(new Agent(x, y));
  }
 
  background(0);
}

void draw(){
  //background(200);
  //fill(0, 1);
  //rect(0, 0, width, height);
  blendMode(ADD);
  
  for(Agent a : agents){
    a.update();
  }
  
  float radius = mouseX;//map(mouseX, 0, width, 10, width/2);
  float opacity = map(mouseY, 0, height, 1, 10);
  
  for(Agent a1 : agents){
    stroke(255, opacity);
    point(a1.loc.x, a1.loc.y);
          
    for(Agent a2 : agents){
      if(a1 != a2){
        float d = a1.loc.dist(a2.loc);
        if(d < radius){
          int c = lerpColor(#d7df71, #0e5f76, map(d, 0, radius, 0, 1));
          //int c = lerpColor(#f9ed69, #6a2c70, map(d, 0, radius, 0, 1));
          stroke(c, opacity);
          //stroke(250, 250, 0, opacity);
          line(a1.loc.x, a1.loc.y, a2.loc.x, a2.loc.y);
        }
      }
    }
  }
}

void mousePressed(){
  background(0);
  agents = new ArrayList<Agent>();
  
  //float cx = width / 2;
  //float cy = height / 2;
  //PVector center = new PVector(cx, cy);
  //emitFromPoint(center, 100);
  
  createCircular();
}

void createCircular(PVector c, float r, int n){
  float a = 0;
  float d = TWO_PI / n;
  for(int i=0; i<360; i++){
    float x = c.x + cos(a) * r;
    float y = c.y + sin(a) * r;
    Agent agent = new Agent(x, y);
    agent.seek(c);
    agent.velocity.mult(random(-1));
    agents.add(agent);
    
    a += d;
  }
}

void createCircular(){
  int n = 100;
  float r = width * .4;
  r = 50;
  float cx = width / 2;
  float cy = height / 2;
  createCircular(new PVector(cx, cy), r, n);
}

void emitFromPoint(PVector c, int n){
  for(int i=0; i<100; i++){
    Agent agent = new Agent(c.x, c.y);
    agent.velocity = PVector.fromAngle(random(0, TWO_PI));
    agent.velocity.mult(random(1));
    //agent.velocity.x = random(-1, 1);
    //agent.velocity.y = random(-1, 1);
    agents.add(agent);
  }
}


void keyPressed(){
  saveFrame("###.jpg");
}