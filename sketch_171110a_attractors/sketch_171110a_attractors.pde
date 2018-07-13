//look also: https://codepen.io/ge1doot/pen/ooNvgx

ArrayList<Agent> agents;
ArrayList<PVector> attractors;

void setup() {
  size(1200, 1200);

  initAgents();
  initAttractors();
  background(0);
}

void initAgents(){
  agents = new ArrayList<Agent>();
  for (int i=0; i<10000; i++) {
    float x = random(width);
    float y = random(height);
    agents.add(new Agent(x, y));
  }
}

void initAttractors() {
  attractors = new ArrayList<PVector>();

  for (int i=0; i<8; i++) {
    float x = random(width);
    float y = random(height);
    attractors.add(new PVector(x, y));
  }
}
  

void draw() {
  for (Agent agent : agents) {
    stroke(255, 25);
    point(agent.loc.x, agent.loc.y);

    for(PVector a : attractors) {
      agent.seek(a);
    }
    
    agent.update();
  }
}

void mousePressed() {
  initAgents();
  initAttractors();
}

void keyPressed() {
  saveFrame("###.jpg");
}