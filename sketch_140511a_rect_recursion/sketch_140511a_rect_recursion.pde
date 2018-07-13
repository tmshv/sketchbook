int deepLevels = 8;

void setup(){
  size(900, 500);
  frameRate(1);
}

void draw(){
  Rect startRect = new Rect(
    new PVector(30, 30),
    new PVector(width-30, height-30)
  );
  
  doRecursion(startRect, 0);
}

void doRecursion(Rect area, int level){
  if(level > deepLevels) return;
  
  stroke(0);
  strokeWeight(1+ deepLevels-level);
  rect(area.tl.x, area.tl.y, area.getWidth(), area.getHeight());
  
  PVector rp = randomInRect(area);
  Rect[] split = area.splitByPoint(rp);
  for(Rect r : split){
    doRecursion(r, level+1);
  }  
}

PVector randomInRect(Rect rect){
  int w = rect.getWidth();
  int h = rect.getHeight();

  int x = (int) (rect.tl.x + random(0, w));
  int y = (int) (rect.tl.y + random(0, h));
  return new PVector(x, y);  
}


