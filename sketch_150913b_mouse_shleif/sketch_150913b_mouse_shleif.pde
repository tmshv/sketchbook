void setup(){
  size(600, 600);
  background(0);
  frameRate(100);
}

void draw(){
  
  int opacity = (int) map(mouseX, 0, width, 50, 200);
  opacity = 10;
  
  pushStyle();
  fill(0, opacity);
  noStroke();
  rect(0, 0, width, height);
  popStyle();
  
  pushStyle();
  noFill();
  stroke(200, 200, 0);
  strokeWeight(2);
  line(pmouseX, pmouseY, mouseX, mouseY);
  popStyle();
}