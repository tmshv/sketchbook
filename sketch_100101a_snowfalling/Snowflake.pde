class Snowflake{
  float x;
  float y;
  float dx;
  float dy;
  
  Snowflake(){
    update();
    y = random(height);
  }
  
  void update(){
    x = int(random(width));
    y = 0;
    dx = random(-.01, 1);
    dy = random(.1, 2);
  }
  
  void move(){
    x += dx;
    y += dy;
    
    if(x>width || x<0) update();
    if(y>height || y<0) update();
  }
}
