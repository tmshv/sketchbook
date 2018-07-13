String[] source;
int[] dayCount = new int[365];
color [] monthColors = new color[12];
void setup() {
  size(2500, 250);
  
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

    int doy = getDayIndex(date);
    dayCount[doy] += 1;

    String title = source[i+1];
    String artist = source[i+2];
    String album = source[i+3];
  }

  drawDays();
  saveFrame("####.png");
  //println(dayCount);
}

void drawDays() {
  background(0x000000);
  int max_plays = 0;
  for (int i=0; i<dayCount.length; i++) {
    int value = dayCount[i];
    max_plays = max(value, max_plays);
  }

  println(max_plays);
  
  for (int i=0; i<dayCount.length; i++) {
    int value = dayCount[i];
    int h = int(((float)value / (float)max_plays) * 100);
    int w = 5;
    int x = 20 + (w+1) * i;
    
    int m = getMonthByDOY(i);
    color col = monthColors[m];
    println(m);
    fill(col);
    rect(x, 200-h, w, h);
    //    noFill();
  }
}

int getDayIndex(Date date) {
  Date onejan = new Date(date.getYear(), 0, 1);
  return ceil((date.getTime() - onejan.getTime()) / 86400000);
}

int getMonthByDOY(int doy){
  Date d = new Date();
  d.setTime((long)doy * 24 * 60 * 60 * 1000);
  return d.getMonth();
}

