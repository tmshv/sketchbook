String path = "10106.jpg";

PImage img;

void setup(){
  img = loadImage(path);
  size(800, 500);
  //size(600, 600);

}

void draw(){
  background(0);
  
  //int w = (height / img.height) * img.width;
  //int dx = (w - width) / 2;
  //image(img, -dx, 0, w, height);
  
  //int x = width/2;
  //int y = height/2;
  //if(mousePressed){
  //  x = mouseX;
  //  y = mouseY;
  //}

  
  if(mousePressed){
    image(img, 0, 0);
    return;
  }

  int radius = (int) map(mouseX, 0, width, 4, 40);
  int t = (int) map(mouseY, 0, height, 2, 10);
  int r2 = radius * 2;
  
  translate(radius, radius);
  img.loadPixels();
  
  for(int x=0; x<width; x += r2){
    for(int y=0; y<height; y += r2){
        circles(x, y, (int)(radius / t), t, img);
    }
  }
}

void circles(int x, int y, int n, int t, PImage img){
  for(int i=0; i<n; i++){
    int radius = t * n - t * i;
    
    int c = img.get(x+radius, y);
        
    radius *= 2;
    noStroke();
    fill(c);
    
    //noFill();
    //stroke(c);
    strokeWeight(10);
    
    ellipseMode(CENTER);
    ellipse(x, y, radius, radius);
  }
}