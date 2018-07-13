//http://jamie-wong.com/2014/08/19/metaballs-and-marching-squares/
//https://ru.wikipedia.org/wiki/Metaball
//http://labs.byhook.com/2011/09/26/vector-metaballs/

class Agent {
  PVector loc;
  float radius;

  Agent(float x, float y, float r) {
    loc = new PVector(x, y);
    radius = r;
  }

  void draw() {
    pushStyle();
    stroke(255);
    noFill();
    ellipseMode(CENTER);
    ellipse(loc.x, loc.y, radius*2, radius*2);
    popStyle();
  }
}

Agent[] agents;

int step = 1;

void setup() {
  size(600, 600);
  agents = new Agent[30];
  init();
  noLoop();
}

void init() {
  for (int i=0; i<agents.length; i++) {
    float x = random(width);
    float y = random(height);
    float r = random(10, 40);//map(randomGaussian(), 0, 1, 2, 10);
    agents[i] = new Agent(x, y, r);
  }
}

void draw() {
  background(0);

  float factor = map(mouseX, 0, width, 0, 1);
  step = (int) map(mouseY, 0, height, 1, 50);

  int startTime = millis();

  factor = 1;
  step = 1;

  for (int x=0; x<width; x += step) {
    for (int y=0; y<height; y += step) {
      float sum = 0;

      for (Agent a : agents) {
        float dx = x - a.loc.x;
        float dy = y - a.loc.y;
        float value = (a.radius * a.radius) / (dx*dx + dy*dy);
        sum += value;
      }

      noStroke();
      if (sum > factor) {
        fill(#aa1154); 
        rect(x, y, step, step);
      }
    }
  }

  for (Agent a : agents) a.draw();

  println(millis() - startTime);
  saveFrame("metaball-pde.png");
}

void mousePressed() {
  init();
}