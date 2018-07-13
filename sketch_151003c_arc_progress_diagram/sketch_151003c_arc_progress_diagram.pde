class ProgressDiagram {
  PVector location;
  float radius;
  float thickness;
  float startAngle;
  
  int backgroundColor;
  int foregroundColor;
  
  private float ratio;
  
  ProgressDiagram(float r, float x, float y){
      location = new PVector(x, y);
      setProgress(r);
      
      startAngle = 0;
      radius = 50;
      thickness = 3;
      backgroundColor = #ffffff;
      foregroundColor = #10a0da;
  }
  
  void setProgress(float r){
    ratio = constrain(r, 0, 1);
  }
  
  void draw(){
    float s = radius * 2;
    float angle = startAngle + TWO_PI * ratio;
    
    noFill();
    strokeWeight(thickness);
    strokeCap(SQUARE);
    
    stroke(backgroundColor);
    ellipseMode(CENTER);
    ellipse(location.x, location.y, s, s);
    
    stroke(foregroundColor);    
    arc(location.x, location.y, s, s, startAngle, angle, OPEN);
  }
}

ProgressDiagram pd;
int counter = 0;
float factor = 200f;

void setup(){
  size(600, 600, P2D);
  pd = new ProgressDiagram(0, width/2, height/2);
}

void draw(){
  background(0);
  float v = counter / factor;
  pd.setProgress(v);
  pd.draw();
  
  counter ++;
}

void mousePressed(){
  factor = random(10, 500);
  counter = 0;
  pd.radius = abs(width/2 - mouseX);
  pd.thickness = map(mouseY, 0, height, 1, 10);
  pd.setProgress(0);
}