void setup(){
  size(500, 500);
  frameRate(10);  
}

void draw() {
  background(204);
  
  float x1 = random(width); 
  float y1 = random(height);
  float x2 = random(width);
  float y2 = random(height);
  float x3 = random(width); 
  float y3 = random(height);
  float x4 = random(width);
  float y4 = random(height);

  line(x1, y1, x2, y2);
  line(x3, y3, x4, y4);
  
  float[] c1 = getLineCoefs(x1, y1, x2, y2);
  float[] c2 = getLineCoefs(x3, y3, x4, y4);
  
  float[] coord = getCrossCoord(c1, c2);
  
  ellipseMode(CENTER);
  noFill();
  ellipse(coord[0], coord[1], 20, 20);
}

/**
 * return coordinate of crossing two lines defined by {x1; y1}, {x2; y2}
 * @param l1
 * @param l2
 * @return
 */
float[] getCrossCoord(float[] coef1, float[] coef2) {
  float a1 = coef1[0];
  float b1 = coef1[1];
  float c1 = coef1[2];
  float a2 = coef2[0];
  float b2 = coef2[1];
  float c2 = coef2[2];

  float x = (c2 * b1 - c1 * b2) / (a1 * b2 - a2 * b1);
  float y = (c2 * a1 - c1 * a2) / (b1 * a2 - b2 * a1);
  float[] out = {
    x, y
  };
  return out;
}

/**
 * return the free coefficient of base line formula
 * @param x1
 * @param y1
 * @param x2
 * @param y2
 * @return
 */
float[] getLineCoefs(float x1, float y1, float x2, float y2) {
  float[] out  = {
    y2 - y1, x1 - x2, (y1 * x2) - (x1 * y2)
    };
    return out;
}

