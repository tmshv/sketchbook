//float s = 10;
//float r = 28;
//float b = 8/3;
float s = 5;
float r = 15;
float b = 1;
float dt = 0.015;
//float x = 3.051522;
//float y = 1.582542;
//float z = 15.62388;
float x = 1;
float y = 1;
float z = 1;

void setup(){
  size(600, 600, OPENGL);
}

void draw(){
  noFill();
  stroke(10, 10, 10, 10);
  float ss = 7.5;
  
  beginCamera();
  camera(width/2.0, height/2.0, width/2, width/2.0, height/2.0, 0, 0, 1, 0);
  translate(width/2, height/2-100);
  rotateX(-PI/4);
  
//  cameraAngle += -PI/60;
  endCamera();
  
//  translate(0, -height/2);
  
  for(int i=0; i<100; i++){
    float nx = x + s * (y - x) * dt;
    float ny = y + (r*x - y - x*z) * dt;
    float nz = z + (x*y - b*z) * dt;

    line(x*ss, y*ss, z*ss, nx*ss, ny*ss, nz*ss);
    x = nx;
    y = ny;
    z = nz;    
  }
}
