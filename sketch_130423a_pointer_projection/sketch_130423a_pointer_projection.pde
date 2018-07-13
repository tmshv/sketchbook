PVector v1;
PVector v2;

void setup() {
  size(500, 500);
  ellipseMode(CENTER);
  textSize(12);
  // v1 = new PVector(random(width), random(height));
  // v2 = new PVector(random(width), random(height));

  v1 = new PVector(width-100, 250);
  v2 = new PVector(100, 250);
}

void draw(){
  background(204);
  PVector mouse = mouseCoord();
  PVector projection = project(mouse, v1, v2);
  int projectionColor = color(200, 0, 0);
  if(isInsideSegment(projection, v1, v2)) projectionColor = color(0, 200, 0);
  
  line(v1.x, v1.y, v2.x, v2.y);
  line(mouse.x, mouse.y, projection.x, projection.y);
  drawVertex(projection, 10, projectionColor, "projection");
  drawVertex(v1, 4, color(255, 255, 255), "first");
  drawVertex(v2, 4, color(255, 255, 255), "second");
    
  text("dist:" + dist(mouse.x, mouse.y, projection.x, projection.y), mouse.x, mouse.y);
  
  drawComment();
}

void drawVertex(PVector vertex, int size, color c, String message){
  fill(c);
  ellipse(vertex.x, vertex.y, size, size);
  text(message, vertex.x+5, vertex.y);
}

void drawComment(){
  String message = "> click left => specifying first vertex of line;\n";
  message += "> click right => specifying second vertex of line;\n";
  message += "> red circle is projection of mouse pointer on line(first, second);\n";
  text(message, 5, 10);  
}

PVector mouseCoord(){
  return new PVector(mouseX, mouseY);
}

void mousePressed(){
  if(mouseButton == LEFT) v1 = mouseCoord();
  else v2 = mouseCoord();
} 

PVector project(PVector vertex, PVector lineVertex1, PVector lineVertex2) {
  PVector a = new PVector(vertex.x - lineVertex1.x, vertex.y - lineVertex1.y);
  PVector b = new PVector(lineVertex2.x - lineVertex1.x, lineVertex2.y - lineVertex1.y);
  
  float dp = a.dot(b);
  PVector p = b.copy();
  p.mult(dp / b.magSq());  
  return PVector.add(lineVertex1, p);
}

boolean isInsideSegment(PVector v, PVector a, PVector b) {
  PVector pa = PVector.sub(v, a);
  PVector pb = PVector.sub(v, b);

  PVector cross = pa.cross(pb);
  float ps = cross.magSq();

  return pa.dot(pb) < 0 && isEqual(ps, 0, 5E-5);
}

boolean isEqual(float v1, float v2, float precision){
  return abs(v1 - v2) < precision;
}