void setup(){
  size(500, 500);
}

void draw(){
  background(204);
  noFill();
  ellipseMode(CENTER);
  
  float m = map(mouseX, 0, width, 0, 1);
  int n = (int) map(mouseY, 0, height, 10, 50);
  
  recurse(mouseX, mouseY, 100, n, m);
//  recurse(mouseX, mouseY, 100);
}

//void recurse(int x, int y, int s){
//  ellipse(x, y, s, s);
//}

void recurse(int x, int y, int r, int n, float m){
  int s = r * 2;
  ellipse(x, y, s, s);
  if(n > 0){
    int r2 = (int) (r * m);
    int dx = r - r2;
    
    if(r2 > 1){
      recurse(x+dx, y, r2, n-1, m);
    }
  }
}
