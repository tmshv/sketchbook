String[] source;
int[] monthCount = new int[12];
color [] monthColors = new color[12];
float rot = PI;
void setup() {
  size(700, 700);

  //winter
  monthColors[0] = color(200, 221, 228);
  monthColors[1] = color(200, 221, 228);

  //spring
  monthColors[2] = color(174, 216, 37);
  monthColors[3] = color(174, 216, 37);
  monthColors[4] = color(174, 216, 37);

  //summer
  monthColors[5] = color(55, 150, 216);
  monthColors[6] = color(55, 150, 216);
  monthColors[7] = color(55, 150, 216);

  //autumn
  monthColors[8] = color(214, 177, 36);
  monthColors[9] = color(214, 177, 36);
  monthColors[10] = color(214, 177, 36);

  //winter
  monthColors[11] = color(200, 221, 228);

  source = loadStrings("../lfm-tracks");

  int length = source.length;
  //  length = 40;
  for (int i=0; i<length; i+=4) {
    String uts = source[i];
    int timestamp = int(uts);
    long unixtime = timestamp * (long)1000;
    Date date = new Date();
    date.setTime(unixtime);

    int m = getMonthByDOY(getDayIndex(date));
    monthCount[m] += 1;

    String title = source[i+1];
    String artist = source[i+2];
    String album = source[i+3];
  }
  noLoop();
  draw();
  saveFrame("####.png");
}

void draw() {
  background(0x000000);
  noStroke();
  PFont font = loadFont("Monaco-12.vlw");
  textFont(font, 12);

  int max_plays = 0;
  for (int i=0; i<monthCount.length; i++) {
    int value = monthCount[i];
    max_plays = max(value, max_plays);
  }

  float step_angle = PI / 6;

  for (int i=0; i<monthCount.length; i++) {
    int value = monthCount[i];
    int radius = int(((float)value / (float)max_plays) * 650);
    color col = monthColors[i];
    fill(col);
    pushMatrix();
    translate(width/2, height/2);
    rotate(step_angle * i);
    rotate(rot);
    arc(0, 0, radius, radius, 0, step_angle);
    popMatrix();
  }
  for (int i=0; i<monthCount.length; i++) {
    int value = monthCount[i];
    int radius = int(((float)value / (float)max_plays) * 650);
    pushMatrix();
    translate(width/2, height/2);
    rotate(step_angle * i);
    rotate(rot);
    fill(255, 255, 255);
    text(getMonthName(i), radius/2, 0);
    popMatrix();
  }
  fill(0x000000);
  ellipse(width/2, height/2, 100, 100);
  
  rot += PI * 0.01;
}

String getMonthName(int month) {
  String[] names = new String[12];
  names[0] = "Январь";
  names[1] = "Февраль";
  names[2] = "Март";
  names[3] = "Апрель";
  names[4] = "Май";
  names[5] = "Июнь";
  names[6] = "Июль";
  names[7] = "Август";
  names[8] = "Сентябрь";
  names[9] = "Октябрь";
  names[10] = "Ноябрь";
  names[11] = "Декабрь";
  return names[month];
}

int getDayIndex(Date date) {
  Date onejan = new Date(date.getYear(), 0, 1);
  return ceil((date.getTime() - onejan.getTime()) / 86400000);
}

int getMonthByDOY(int doy) {
  Date d = new Date();
  d.setTime((long)doy * 24 * 60 * 60 * 1000);
  return d.getMonth();
}

