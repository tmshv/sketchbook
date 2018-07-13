class Circle {
  int radius;
  color c;
  float rotation;

  public Circle() {
  }

  void draw(PImage env, float angle) {
    float r = (float) env.width / (width);
//    int env_radius = (int) (20 + (r * (radius-30)));
    int env_radius = (int) ((r * (radius)));
    float env_angle = angle + PI / 3;
    int env_x = env.width/2 + (int)(cos(env_angle) * env_radius);
    int env_y = env.height/2 + (int)(sin(env_angle) * env_radius);
    color env_color = env.get(env_x, env_y);
    
    noFill();
    stroke(env_color);
    strokeWeight(2);

    angle += rotation;

    int  h = radius * 2;
    int w = (int) ((radius * 2) * cos(angle));
    ellipse(width/2, height/2, w, h);
  }
}

