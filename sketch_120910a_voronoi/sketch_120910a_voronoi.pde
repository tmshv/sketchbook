import megamu.mesh.*;

PointList points;
ArrayList circles;

void setup() {
  size(500, 500);
  //  frameRate(1);
  circles = new ArrayList();
  int w2 = width/2;
  int h2 = height/2;
  createCircle(10, 50,  w2+30, h2, 0, -PI/200);
  createCircle(30, 150, w2+50, h2, 0, PI/130);
  createCircle(120, 160, w2-100, h2, 0, PI/150);
  createCircle(120, 180, w2+100, h2, 0, -PI/130);
}

void draw() {
  background(204, 204, 204);
  points = new PointList();

  for (int i=0; i<circles.size(); i++) {
    Circ c = (Circ) circles.get(i);
    c.push(points);  
    c.step();
  }
  points.push(width/2, height/2);

  float[][] coords = getCoords();
  Voronoi v = new Voronoi(coords);
  v.getRegions();
  MPolygon[] myRegions = v.getRegions();
  for (MPolygon myRegion : myRegions) {
    //    fill(random(200, 255));
    //    noStroke();
    stroke(150);
    fill(120);
    myRegion.draw(this);
  }

  if (mousePressed) {
    for (float [] pnt : coords) {
      stroke(0);
      point(pnt[0], pnt[1]);
    }
  }
}

float[][] getCoords() {
  float[][] coords = new float[points.size()][2];
  for (int i=0; i<points.size(); i++) {
    coords[i][0] = ((float[]) points.get(i))[0];  
    coords[i][1] = ((float[]) points.get(i))[1];
  }
  return coords;
}

void createCircle(int num, float r, int cx, int cy, float angOffset, float angStep) {
  Circ c = new Circ(num, r, cx, cy, angStep);
  circles.add(c);
}

class Circ {
  float offset;
  float step;
  int num;
  float r;
  int cx;
  int cy;
  public Circ(int num, float r, int cx, int cy, float step) {
    offset = 0;
    this.num = num;
    this.r = r;
    this.cx = cx;
    this.cy = cy;
    this.step = step;
  }

  void step() {
    offset = offset + step;
  }

  void push(PointList points) {
    float ang = offset;
    float ang_step = PI / num;
    for (int i=0; i<num; i++) {
      float x = cx + cos(ang) * r;
      float y = cy + sin(ang) * r;    
      points.push(x, y);
      ang += ang_step;
    }
  }
}

class PointList extends ArrayList {
  void push(float x, float y) {
    float[] c = new float[2];
    c[0] = x;
    c[1] = y;
    this.add(c);
  }
}

