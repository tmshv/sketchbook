ArrayList<Agent> agents;
ArrayList<Connection> links;

void setup(){
  fullScreen(P3D);
  //size(1000, 1000, P3D);
  
  agents = new ArrayList<Agent>();
  for(int i=0; i<100; i++){
    float s = 1;//random(5);
    Agent a = new Agent(random(width), random(height), s);
    agents.add(a);
  }
  
  background(0);
  background(230, 230, 0);
}

void draw(){
  links = new ArrayList<Connection>();
  float r = mmx(10, 100);
  for(Agent a : agents){
    for(Agent b : agents){
      if(a != b && a.distanceTo(b) < r){
        links.add(a.connect(b));
      }
    }    
  }
  
  for(Connection c : links) c.update();
  
  for(Agent a : agents){
    if(a.location.x < 0 ||
      a.location.x > width ||
      a.location.y < 0 ||
      a.location.y > height){
        PVector center = new PVector(width/2, height/2);
        center = a.seek(center);
        a.force(center);
    }  
  }
  
  for(Agent a : agents) a.update();
  
  background(230, 230, 0);
//fade(30);
  for(Connection c : links) c.draw();
  for(Agent a : agents) a.draw();  
}

void mousePressed(){
  for(Agent a : agents){
    a.location.x = random(width);
    a.location.y = random(height);
  }    
}

float mmx(float a, float b){
  return map(mouseX, 0, width, a, b);
}

void fade(int o){
  fill(0, o);
  rect(0, 0, width, height);
}