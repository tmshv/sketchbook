//tmshv
//13.08.2015
//NOC Inspired Random Walker

class Walker {
  float x;
  float y;
  int c;
  
  Walker(float x, float y, int c){
    this.x = x;
    this.y = y;
    this.c = c;
  }
  
  void display(){
    noStroke();
    fill(c);
    ellipseMode(CENTER);
    ellipse(x, y, 1, 1);
  }
  
  void step(){
    step2();
  }
  
  void step1(){
    if(random(1) < 0.01) {
     this.x += random(-20, 20);
     this.y += random(-20, 20);
    }else{
     this.x += random(-1, 1);
     this.y += random(-1, 1);
    }
  }
  
  void step2(){
    int choise = int(random(4));
    if(choise == 0) this.x += 1;
    else if(choise == 1) this.x -= 1;
    else if(choise == 2) this.y += 1;
    else this.y -= 1;
  }
}

Walker[] w;

void setup(){
  size(500, 500);
  w = new Walker[10];
  for(int i=0; i<w.length; i++){
    w[i] = new Walker(width/2, height/2, int(map(noise(i), 0, 1, 0, 255)));    
  } 
}

void draw(){
  for(int i=0; i<100000; i++){
    for(Walker walker : w){
      walker.display();
      walker.step();
    }
  }
  
  noLoop();
}