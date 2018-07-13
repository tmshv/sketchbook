ArrayList<Rect> rs;

int numberOfRects = 500;

void setup(){
  fullScreen();
  rs = new ArrayList<Rect>();
  
  for(int i = 0; i < numberOfRects; i ++){
    Rect r = new Rect(10, 10);
    r.location.x = random(width);
    r.location.y = random(height);
    
    r.speed.x = random(-2, 2);
    r.speed.y = random(-2, 2);
    
    r.fillColor = (int) random(100, 255);
    
    rs.add(r);
  }
}

void draw(){
  noStroke();
  
  for(Rect r : rs){
    r.move();
    
    fill(r.fillColor);  
    rect(r.location.x, r.location.y, r.width, r.height);
  }
}

class Rect {
  float width;
  float height;
  
  PVector location = new PVector();
  PVector speed = new PVector();
  
  int fillColor = 0;
  
  Rect(float w, float h){
    width = w;
    height = h;
  }
  
  void move(){
    location.add(speed);     
  }
}