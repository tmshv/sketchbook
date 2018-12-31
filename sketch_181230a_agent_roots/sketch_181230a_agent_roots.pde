import java.util.Iterator;

class Agent {
  PVector loc;
  PVector vel;
  PVector acc;
  float mass;
  float damping;

  PVector dir;

  Agent() {
    this.loc = new PVector();
    this.vel = new PVector();
    this.acc = new PVector();
    this.mass = 1;
    this.damping = 0.9;
  }

  PVector seek(PVector target) {
    return PVector.sub(target, loc);
  }

  PVector flee(PVector target) {
    return PVector.mult(seek(target), -1);
  }

  void force(PVector f) {
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

  void update() {
    vel.add(acc);
    vel.mult(1 - damping);

    mass -= 0.04;

    loc.add(vel);
    acc.mult(0);
  }

  void draw() {
    int s = int (5 * mass);

    stroke(0);
    fill(255);
    ellipseMode(CENTER);
    ellipse(loc.x, loc.y, s, s);
  }
}

ArrayList<Agent> agents;
boolean fade = true;

void setup() {
  size(800, 800);
  pixelDensity(2);

  agents = new ArrayList();

  for (int i=0; i<4; i++) {
    Agent a = initAgent(new Agent());
    agents.add(a);
  }
}

Agent initAgent(Agent a) {
  //float x = random(width);
  float x = random(-width/2, width/2);
  float y = random(height);
  float angle = 0;//random(-HALF_PI, HALF_PI);
  a.loc.set(x, y);
  a.dir = PVector.fromAngle(angle);
  a.mass = random(5, 7);

  return a;
}

void draw() {
  if (fade) {
    noStroke();
    fill(0, 1);
    rect(0, 0, width, height);
  } else {
    //saveFrame("####.jpg");
  }

  int c = agents.size();
  
  ArrayList<Agent> branches = new ArrayList();
  
  Iterator<Agent> iter = agents.iterator();
  while(iter.hasNext()) {
    Agent a = iter.next();
    if (a.mass <= 0) {
      iter.remove();
      c --;
      continue;
      //initAgent(a);
    }
    
    float p = 0.2;//a.mass * 0.03;
    
    if (random(10) < p) {
      Agent b = initAgent(new Agent());
      float s = PI * 0.1;
      float bd = random(-s, s);
      b.dir = PVector.add(a.dir, PVector.fromAngle(bd));
      b.loc.x = a.loc.x;
      b.loc.y = a.loc.y;
      b.mass = a.mass;

      branches.add(b);
    }

    float angle = random(TWO_PI);
    PVector v = PVector.fromAngle(angle);
    v.mult(15 * a.mass);

    float dm = 30 * a.mass;
    a.force(PVector.mult(a.dir, dm));
    a.force(v);
    a.update();
    a.draw();
  }
  
  agents.addAll(branches);
  
  fade = c > 190;
}
