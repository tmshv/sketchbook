import java.util.Iterator;

class Camera {
  float rotation = 0;
  float scale = 1;

  void setup() {
    translate(width / 2, height / 2);
    rotate(rotation);
    scale(scale);
  }
}

class Cursor {
  float rotation = 0;
  float angularSpeed = PI / 20;

  float r;

  Cursor(float radius) {
    r = radius;
  }

  void moveLeft() {
    rotation -= angularSpeed;
  }

  void moveRight() {
    rotation += angularSpeed;
  }

  void draw() {
    noStroke();
    fill(0);
    float x = cos(rotation) * r;
    float y = sin(rotation) * r;
    ellipse(x, y, 5, 5);
  }
}

class Emitter {
  ArrayList<Particle> particles;

  Emitter(ArrayList<Particle> list) {
    particles = list;
  }

  void emit() {
  }
}

class RandomEmitter extends Emitter {
  RandomEmitter(ArrayList<Particle> list) {
    super(list);
  }

  void emit() {
    int a = (int) random(0, 6);
    particles.add(new Particle(a, 450, 20, 1));
  }
}

class FiveSegmentsEmitter extends Emitter {
  int startAngle = 0;
  FiveSegmentsEmitter(ArrayList<Particle> list, int a) {
    super(list);
    startAngle = a;
  }

  void emit() {
    int a = startAngle;
    particles.add(new Particle(a+0, 450, 20, 1));
    particles.add(new Particle(a+1, 450, 20, 1));
    particles.add(new Particle(a+2, 450, 20, 1));
    particles.add(new Particle(a+3, 450, 20, 1));
    particles.add(new Particle(a+4, 450, 20, 1));
  }
}

class Particle {
  int angle;
  float radius;
  float thickness;
  float speed;

  Particle(int a, float r, float t, float s) {
    angle = a;
    radius = r;
    thickness = t;
    speed = s;
  }

  void update() {
    radius -= speed;
  }

  void draw() {
    float r = radius;
    float r2 = radius + thickness;
    float a = angle * PI / 3;
    float ca = cos(a);
    float sa = sin(a);
    fill(0);
    beginShape();
    vertex(ca * r, sa * r);
    vertex(ca * r2, sa * r2);

    a += PI / 3;
    ca = cos(a);
    sa = sin(a);
    vertex(ca * r2, sa * r2);
    vertex(ca * r, sa * r);
    endShape(CLOSE);
  }
}

Camera cam;
Cursor cursor;
Emitter emitter;

int counter = 0;
int countMax = 100;

ArrayList<Particle> particles;

void setup() {
  cam = new Camera();
  cursor = new Cursor(60);
  particles = new ArrayList<Particle>();

  particles.add(new Particle(0, 100, 20, 1));
  particles.add(new Particle(1, 150, 20, 1));

  //emitter = new RandomEmitter(particles);
  emitter = new FiveSegmentsEmitter(particles, 4);

  fullScreen(P3D);
}

void draw() {
  background(0);
  noStroke();

  updateEmitter();

  if (keyPressed) {
    if (keyCode == LEFT) cursor.moveLeft();
    else if (keyCode == RIGHT) cursor.moveRight();
  }

  cam.rotation += 0.01;
  cam.scale = 2 + sin(frameCount * 0.05);
  cam.setup();

  fill(#bbbb00); drawSegment(width, 0);
  fill(#b0b000); drawSegment(width, 1);
  fill(#bbbb00); drawSegment(width, 2);
  fill(#b0b000); drawSegment(width, 3);
  fill(#bbbb00); drawSegment(width, 4);
  fill(#b0b000); drawSegment(width, 5);

  fill(#cccc00);
  beginShape();
  float angle = 0;
  float r = 40;
  for (int i=0; i<6; i++) {
    float x = cos(angle) * r;
    float y = sin(angle) * r;
    angle += PI / 3;
    vertex(x, y);
  }
  endShape(CLOSE);

  Iterator<Particle> i = particles.iterator();
  while (i.hasNext()) {
    Particle p = i.next();
    p.update();
    if (p.radius < 40) i.remove();

    p.draw();
  }

  cursor.draw();
}

void updateEmitter() {
  counter ++;
  counter %= countMax;
  if (counter != 0) return;
  
  int a = (int) random(0, 6);
  emitter = new FiveSegmentsEmitter(particles, a);  
  emitter.emit();
}

void drawSegment(float r, int a) {
  beginShape();
  vertex(0, 0);
  float angle = (PI / 3) * a;
  for (int i=0; i<2; i++) {
    float x = cos(angle) * r;
    float y = sin(angle) * r;
    angle += PI / 3;
    vertex(x, y);
  }
  endShape(CLOSE);
}
