import java.util.HashMap;

void setup() {
  size(1110, 1110);
  background(color(0, 2, 4));
  String[] a = loadStrings("tags");

  HashMap hm = new HashMap();

  String[] nodes = getNodes(a);
  PFont font = loadFont("Monaco-48.vlw");
  textFont(font, 12);
  pushMatrix();
  translate(0, 1100);
  rotate(-PI/2);
  textAlign(RIGHT);
  for (int i=0; i<nodes.length; i++) {
    int x = 150;
    int y = 11 + 11 * i;

    hm.put(nodes[i], y);

    text(nodes[i], x, y);
  }
  popMatrix();
  
  
  noFill();
  
//  pushMatrix();
//  rotate(PI/10);
//  translate(500, -300);
  
  String[] edges = getEdges(a);
  for (int i=0; i<edges.length; i++) {
    String[] m = edges[i].split("<->");
    String n1 = m[0];
    String n2 = m[1];
    int pos1 = (Integer) hm.get(n1);
    int pos2 = (Integer) hm.get(n2);
    int diff = max(pos1, pos2) - min(pos1, pos2);
    int center = min(pos1, pos2) + diff/2;
    
//    colorMode(HSB, 360, 100, 100);
//    stroke(color(360, 100, 100));
    float alp = 1 - (float) diff / width;
    stroke(color(100, 100, 100, (int) 100 * alp));
    
    arc(center, 940, diff, diff, PI, TWO_PI);
  }
  
  saveFrame("bigpicture-tags-####.png");
}

String[] getNodes(String[] list) {
  int l = getNodesCount(list);
  String[] nodes = new String[l];
  int count = 0;
  for (int i=0; i<list.length; i++) {
    String[] m = list[i].split("<->");
    if (m.length < 2) {
      nodes[count] = list[i];
      count ++;
    }
  }
  return nodes;
}

String[] getEdges(String[] list) {
  int l = getEdgesCount(list);
  String[] edges = new String[l];
  int count = 0;
  for (int i=0; i<list.length; i++) {
    String[] m = list[i].split("<->");
    if (m.length > 1) {
      edges[count] = list[i];
      count ++;
    }
  }
  return edges;
}

int getNodesCount(String[] list) {
  int count = 0;
  for (int i=0; i<list.length; i++) {
    String[] m = list[i].split("<->");
    if (m.length < 2) {
      count ++;
    }
  }
  return count;
}

int getEdgesCount(String[] list) {
  int count = 0;
  for (int i=0; i<list.length; i++) {
    String[] m = list[i].split("<->");
    if (m.length > 1) {
      count ++;
    }
  }
  return count;
}

