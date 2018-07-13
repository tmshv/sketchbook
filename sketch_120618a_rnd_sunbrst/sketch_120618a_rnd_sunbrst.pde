int max_radius = 200;
String filenamepattr;

void setup() {
  size(500, 500);
  smooth();
  clear();
  frameRate(15);
}

void draw() {
  draw2();
}

void draw3() {
  filenamepattr = "rnd-sunbrst3-####.png";

  float thickness = 20;
  clear();

  int num = (int) (max_radius / thickness);

  for (int i=1; i<num; i++) {
    float inner_radius = i * (max_radius / num);
    float outer_radius = inner_radius + thickness;

    float start_a = random(0, 360) * (PI / 180);
    float finish_a = start_a + random(360)*(PI/180);
    
    color c = color(random(255), random(255), random(255));
    drawArc(start_a, finish_a, inner_radius, outer_radius, 100, c);
  }
}

void draw2() {
  filenamepattr = "rnd-sunbrst2-####.png";

  float start_a = random(0, 360) * (PI / 180);
  float finish_a = start_a + random(150)*(PI/180);

  float thickness = 90;
  float outer_radius = max_radius;
  float inner_radius = outer_radius - thickness;

  //color c = color(random(255), random(255), random(255));
  color c = color(20, 20, random(255));
  drawArc(start_a, finish_a, inner_radius, outer_radius, 100, c);
}

void draw1() {
  filenamepattr = "rnd-sunbrst-####.png";

  float start_a = random(0, 360) * (PI / 180);
  float finish_a = start_a + random(150)*(PI/180);

  float thickness = random(2, 90);
  float outer_radius = random(100, max_radius);
  float inner_radius = outer_radius - thickness;

  color c = color(random(255), random(255), random(255));
  drawArc(start_a, finish_a, inner_radius, outer_radius, 100, c);
}

void drawArc(float start_a, float finish_a, float inner_radius, float outer_radius, int pass, color c) {
  fill(c);
  noStroke();

  int center_x = width / 2;
  int center_y = height / 2;

//  int pass_number = 300;
//  float angular_step = (finish_a - start_a) / (float) pass_number;
  float angular_step = .1 * (PI/180);
  int pass_number = (int)((finish_a - start_a) / angular_step);
  float current_angle = start_a;
  int cur_x = 0;
  int cur_y = 0;

  beginShape();

  for (int i=0; i<pass_number; i++) {
    cur_x = center_x + (int)(cos(current_angle) * inner_radius);
    cur_y = center_y + (int)(sin(current_angle) * inner_radius);
    vertex(cur_x, cur_y);
//    point(cur_x, cur_y);
    current_angle += angular_step;
  }

  current_angle = finish_a;
  for (int i=0; i<pass_number; i++) {
    cur_x = center_x + (int)(cos(current_angle) * outer_radius);
    cur_y = center_y + (int)(sin(current_angle) * outer_radius);
    vertex(cur_x, cur_y);
//    point(cur_x, cur_y);
    current_angle -= angular_step;
  }
  endShape(CLOSE);
}

void mousePressed() {
  saveFrame(filenamepattr);
  clear();
  max_radius = (int) random(100, 220);
}

void clear() {
  background(color(237, 237, 237));
}

