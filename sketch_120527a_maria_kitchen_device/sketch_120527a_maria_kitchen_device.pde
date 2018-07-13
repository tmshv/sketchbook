Circle[] list = new Circle[30];

float angle = 0;
PImage environment;

void setup() {
  size(700, 700); 
  smooth();
  environment = loadImage("environment.png");

  for (int i=0; i<list.length; i++) {
    Circle c = new Circle();
    c.radius = (30 + 20*i) / 2;
    c.rotation = i * 2 * (PI/180);
    c.c = color(random(255), random(255), random(255));
    list[i] = c;
  }

  //  list[0].radius = 200;

  frameRate(50);
}

void draw() {
  background(0);//204, 204, 204);

//  image(environment, 0, 0);//, width, height);

  for (int i=0; i<list.length; i++) {
    Circle c = list[i];
    c.draw(environment, angle);
  }

  if (!mousePressed) {
    float step_mult = (float) mouseX / width;
    float step = -3.0 + (6.0 * step_mult);
    step = 1.5;
    angle += step * (PI/180);
  }
}

