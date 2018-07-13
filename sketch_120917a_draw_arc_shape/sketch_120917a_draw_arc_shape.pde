float startAngle;
float finishAngle;
color arcColor;
int outerRadius;
int thickness;
float step;

void setup() {
  size(800, 800);

  startAngle = 80 * (PI/180);
  finishAngle = 248 * (PI/180);
  arcColor = color(200, 0, 0);
  outerRadius = width / 2 - 40;
  thickness = 100;
  step = 1 * (PI/180);
}

void randomInit() {
  int w2 = width / 2;

  startAngle = 0;//random(360) * (PI/180);
  finishAngle = startAngle;
  arcColor = color(random(256), random(256), random(256));
  outerRadius = (int) random(w2-100, w2-10);
  thickness = (int) random(10, 200);
  step = random(5) * (PI/180);
}

void draw() {
  if (finishAngle * (180/PI) > 380) {
    randomInit();
  }
  
//  clear();

  //  outerRadius = mouseX;

  int inner = outerRadius - thickness;
  //  inner = mouseY;
  drawArc(startAngle, finishAngle, inner, outerRadius, arcColor);
  finishAngle += step;
  
}

void clear() {
  background(255, 255, 255);
}

void drawArc(float start_a, float finish_a, float inner_radius, float outer_radius, color c) {
  fill(c);
  noStroke();
  //  stroke(0);

  float angle_delta = finish_a - start_a;
  int center_x = width / 2;
  int center_y = height / 2;
  int pass_length = 1;
  int pass_number = 0;
  float angular_step = 0;
  float cur_x = 0;
  float cur_y = 0;
  float current_angle = 0;
  float arc_length = 0;

  beginShape();

  angular_step = 2 * asin(pass_length/inner_radius/2);
  arc_length = angle_delta * inner_radius;
  pass_number = (int)(arc_length / pass_length);
  current_angle = start_a;
  for (int i=0; i<pass_number; i++) {
    cur_x = center_x + (cos(current_angle) * inner_radius);
    cur_y = center_y + (sin(current_angle) * inner_radius);
    vertex((int) cur_x, (int) cur_y);
    current_angle += angular_step;
  }

  angular_step = 2 * asin(pass_length/outer_radius/2);
  arc_length = angle_delta * outer_radius;
  pass_number = (int)(arc_length / pass_length);
  current_angle = finish_a;
  for (int i=0; i<pass_number; i++) {
    cur_x = center_x + (cos(current_angle) * outer_radius);
    cur_y = center_y + (sin(current_angle) * outer_radius);
    vertex((int) cur_x, (int) cur_y);
    current_angle -= angular_step;
  }

  endShape(CLOSE);
}

