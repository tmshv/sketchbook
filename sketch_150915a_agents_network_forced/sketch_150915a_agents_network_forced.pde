//http://getspringy.com
//https://en.wikipedia.org/wiki/Force-directed_graph_drawing
//https://www.youtube.com/watch?v=HQBMfozLa4Y

Agent a;

ArrayList<Link> links = new ArrayList<Link>();
ArrayList<Agent> agents = new ArrayList<Agent>();

int n = 2;
int d = 5;

float repulsion = 5000;
float mass = 1;
float k = 1;
float damping = .95f;
float springLength = 50;

Agent selectedAgent;

void setup() {
  fullScreen();

  a = createAgent(width/2, height/2);
  branch(a, n, d);
}

void draw() {
  background(0);

  if (keyPressed) {
    if (keyCode == ALT) {
      repulsion = map(mouseX, 0, width, 0, 15000);
    }

    if (keyCode == SHIFT) {
      k = map(mouseX, 0, width, 0, 3);
    }
  }

  applyCouloumbsLaw(repulsion, agents);
  applyHooksLaw(k, links);

  for (Agent a : agents) a.update();
  for (Link l : links) l.draw();

  if (selectedAgent != null) selectedAgent.loc.set(mouseX, mouseY);

  fill(255);
  text("repulsion:"+repulsion, 10, 15);
  text("k:"+k, 10, 30);
  text("kinetic:"+calcKineticEnergy(agents), 10, 45);
}

Agent createAgent(float x, float y) {
  Agent a = new Agent(x, y, mass, damping);
  agents.add(a);
  return a;
}

Link createLink(Agent a1, Agent a2, float sl) {
  Link link = new Link(a1, a2, sl, k);
  links.add(link);
  return link;
}

void branch(Agent a, int n, int d) {
  for (int i=0; i<n; i++) {
    float x = random(width);
    float y = random(height);
    Agent b = createAgent(x, y);
    Link link = createLink(a, b, springLength - d*10);

    if (d > 0) {
      branch(b, n, d-1);
    }
  }
}

void applyCouloumbsLaw(float repulsion, ArrayList<Agent> agents) {
  PVector f;
  for (Agent a : agents) {
    for (Agent b : agents) {
      if (a != b) {
        float d = a.loc.dist(b.loc);
        if(d == 0) d = 0.001;

        f = a.flee(b.loc);
        f.normalize();
        f.mult(repulsion);
        f.div(d * d);

        a.force(f);
        f.mult(-1);
        b.force(f);
      }
    }
  }
}

void applyHooksLaw(float k, ArrayList<Link> links) {
  PVector f;
  for (Link l : links) {
    f = l.a1.seek(l.a2.loc);
    float displacement = l.length - f.mag();
    f.normalize();
    f.mult(k * displacement);

    l.a2.force(f);
    f.mult(-1);
    l.a1.force(f);
  }
}

float calcKineticEnergy(ArrayList<Agent> agents) {
  float total = 0;
  for (Agent a : agents) {
    float s = a.vel.mag();
    total += 0.5 * a.mass * s * s;  
  }
  return total;
}

void mousePressed() {
  Agent nearest = null;
  float minDist = 1000000000;
  for (Agent a : agents) {
    float d = dist(mouseX, mouseY, a.loc.x, a.loc.y);
    if (d < minDist) {
      minDist = d;
      nearest = a;
    }
  }

  selectedAgent = nearest;
}

void mouseReleased() {
  selectedAgent = null;
}

void keyPressed() {
  if (keyCode == TAB) {
    for (Agent a : agents) {
      a.loc.set(
        random(width), 
        random(height)
        );
    }
  }
}