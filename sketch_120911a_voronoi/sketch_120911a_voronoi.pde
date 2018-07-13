import megamu.mesh.*;

ArrayList points = new ArrayList();

int[] colors;

void setup() {
  size(800, 800);
//  push(200, 100);
//  push(700, 200);
//  push(650, 650);
//  push(200, 700);
//  push(100, 400);

  for(int i=0; i<200; i++){
    push(random(width), random(height));  
  }
  
  colors = new int[200];
  for(int i=0; i<colors.length; i++){
    colors[i] = (int) random(200, 255);
  }
}

void draw() {
  background(204);
  
  //float[][] coords = getCoords();
  float[][] coords = getCoords2(mouseX, mouseY);
  
  noFill();
  stroke(100);

  Voronoi myVoronoi = new Voronoi(coords);
  MPolygon[] myRegions = myVoronoi.getRegions();
  int i=0;
  for(i=0; i<myRegions.length-1; i++){
    fill(colors[i]);
    float[][] regionCoordinates = myRegions[i].getCoords();
    drawDirectCurve(regionCoordinates);
  }
  fill(200, 50, 0);
  float[][] regionCoordinates = myRegions[i].getCoords();
  drawDirectCurve(regionCoordinates);
 
  if (mousePressed) {
    for (i=0; i<coords.length; i++) {
      float [] pnt = coords[i];
      stroke(0);
      fill(0);
      point(pnt[0], pnt[1]);
      text(str(i), pnt[0]+5, pnt[1]+15);
    }
  }
}

void drawDirectCurve(float[][] coords) {
  beginShape();
  for (int i=0; i<coords.length; i++) {
    float [] p1 = coords[i % coords.length];    
    float [] p2 = coords[(i+1)% coords.length];
    float [] p3 = coords[(i+2)% coords.length];
    float [] c1 = getCenter(p1, p2);
    float [] c2 = getCenter(p2, p3);

    //bezier(c1[0], c1[1], p2[0], p2[1], p2[0], p2[1], c2[0], c2[1]);
    if(i == 0){
      vertex(c1[0], c1[1]);
    }
    bezierVertex(p2[0], p2[1], p2[0], p2[1], c2[0], c2[1]);  
  }
  endShape();
}

float[] getCenter(float[] p1, float[] p2) {
  float[] c = new float[2];
  c[0] = (p1[0] + p2[0]) / 2;
  c[1] = (p1[1] + p2[1]) / 2;
  return c;
}

void push(float x, float y) {
  float[] c = new float[2];
  c[0] = x;
  c[1] = y;
  points.add(c);
}

float[][] getCoords() {
  float[][] coords = new float[points.size()][2];
  for (int i=0; i<points.size(); i++) {
    coords[i][0] = ((float[]) points.get(i))[0];  
    coords[i][1] = ((float[]) points.get(i))[1];
  }
  return coords;
}

float[][] getCoords2(float x, float y) {
  float[][] coords = new float[points.size()+1][2];
  int i=0;
  for (i=0; i<points.size(); i++) {
    coords[i][0] = ((float[]) points.get(i))[0];  
    coords[i][1] = ((float[]) points.get(i))[1];
  }
  coords[i][0] = x;  
  coords[i][1] = y;
  return coords;
}
