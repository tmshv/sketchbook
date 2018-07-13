//import processing.pdf.*;

//PGraphicsPDF pdf;

PImage heart;

void setup() {
  pixelDensity(2);
  size(800, 600);
  //fullScreen(1);
  //background(0);

  heart = loadImage("heartw.png");

  //pg = createGraphics(200, 200);
  //pdf = (PGraphicsPDF) beginRecord(PDF, "sf.pdf");
  
  noLoop();
  //frameRate(1);
}

void draw(){
  background(255);
  
  blendMode(DIFFERENCE);
  
  //noStroke();
  //fill(255);
  
  int s = 25;
  
  for(int i=0; i<1500; i++){
    pushMatrix();
    
    float x = random(0, width);
    float y = random(0, height);
    //float x = width/2;
    //float y = height/2;
    
    translate(x, y);
    rotate(random(TWO_PI));
    
    image(heart, 0, 0, s, s);
    
    popMatrix();
  }
  
  saveFrame("y18-###.png");
  //pdf.nextPage();
}

//void mousePressed() {
//  endRecord();
//  exit();
//}
