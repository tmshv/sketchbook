import java.util.Iterator;

ArrayList<Agent> agents;
int n = 5000;

void setup(){
  size(600, 600);
  smooth();
  
  agents = new ArrayList<Agent>();
  for(int i=0; i<n; i++) addAgent(1);
  
  background(255, 255, 255);
}

void draw(){
  Iterator i = agents.iterator();
  while(i.hasNext()){
    Agent a = (Agent) i.next();

    if(a.location.x < 0 || a.location.x > width || a.location.y < 0 || a.location.y > height){
        i.remove();
    }
    
    a.update();
    a.draw();
  }
}

void addAgent(int s){
  Agent a = new Agent(random(width), random(height), s);
  agents.add(a);
}

void keyPressed(){
  if(key == ' ') saveFrame("###.jpg");
}