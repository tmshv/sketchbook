Snowflake[] snowlist;
int num;

void setup(){
  size(800, 600);
  background(53, 64, 88);
  stroke(255);
  smooth();
  
  num = 1000;
  snowlist = new Snowflake[num];
  for(int i=0; i<num; i++) snowlist[i] = new Snowflake();
}

void draw(){
  background(53, 64, 88);
  //if(mousePressed) line(pmouseX, pmouseY, mouseX, mouseY);
  for(int i=0; i<num; i++){
    Snowflake s = snowlist[i];
    point(s.x, s.y);
    s.move();
  }
}
