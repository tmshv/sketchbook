PVector center;

ArrayList<Agent> agents = new ArrayList<Agent>();

void setup(){
  //fullScreen();
  size(600, 600);
  
  center = new PVector(width/2, height/2);
  
  for(int i=0; i<100; i++){
    float a = 2.5;
    //float x = map(randomGaussian(), -a, a, 0, width);
    //float y = map(randomGaussian(), -a, a, 0, height);
    float x = random(width);
    float y = random(height);
    
    PVector c = new PVector(x, y);
    float d = c.dist(center);
    d = max(d, 0.01);
    float smin = min(150, map(d, 0, width/2, 250, 20));
    //int s = (int) smin;
    int s = (int) random(smin, smin+50);
    s = 150;
    Agent agent = new Agent(x, y, s); 
    agent.vel = PVector.sub(center, agent.loc);
    agent.vel.normalize();
    agents.add(agent);
  }
}

void draw(){
  background(0);
  
  blendMode(DIFFERENCE);
  
  noStroke();
  fill(255);
  
  for(Agent a : agents){
    //a.update();
    a.draw();
  }
}

class Agent{
  float size;
  PVector loc;
  PVector vel;
  
  public Agent(float x, float y, float s){
    size = s;
    loc = new PVector(x, y);
    vel = PVector.random2D();
  }
  
  void update(){
    loc.add(vel);
  }
  
  void draw(){
    ellipseMode(CENTER);
    ellipse(loc.x, loc.y, size, size);  
  }
}

void keyPressed(){
   saveFrame("###.jpg"); 
}