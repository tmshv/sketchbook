import processing.pdf.*;
import controlP5.CallbackEvent;
import controlP5.ControlP5;
import controlP5.Slider;

Tree tree;
TreeRenderer view;

int thickness;
int radius;
int rot;

ControlP5 cp5;
int pos = 10;

private int _leafSliderCounter = 0;

HashMap<Integer, ITree> mapCP5;

@Override
public void setup() {
  size(700, 700);
  mapCP5 = new HashMap<Integer, ITree>();
  cp5 = new ControlP5(this);
  cp5.addSlider("thickness")
    .setPosition(10, pos)
      .setSize(200, 20)
        .setRange(1, 100)
          .setValue(30);
  pos += 25;
  cp5.addSlider("radius")
    .setPosition(10, pos)
      .setSize(200, 20)
        .setRange(50, width / 2)
          .setValue(100);
  pos += 25;
  pos += 25;

  tree = new Tree("root", color(255, 255, 255));
  initTree();

  view = new TreeRenderer(tree);
  view.center.x = width / 2;
  view.center.y = height / 2 + 100;
}

public void initTree(){
  Tree individ = (Tree) tree.add(new Tree("individ", color(253, 60, 45)));
  addLeaf("num_block", new Leaf("block", 50, color(216, 90, 157)), individ);
  addLeaf("num_private", new Leaf("private", 75, color(242, 175, 62)), individ);

  Tree urban = (Tree) tree.add(new Tree("urban", color(0, 109, 73)));
  addLeaf("num_1", new Leaf("1 room", 101, color(241, 220, 113)), urban);
  addLeaf("num_2", new Leaf("2 room", 201, color(155, 191, 81)), urban);
  addLeaf("num_3", new Leaf("3 room", 62, color(112, 154, 82)), urban);
  addLeaf("num_4", new Leaf("4 room", 25, color(48, 141, 112)), urban);  
}

public Leaf addLeaf(String field, Leaf leaf, Tree tree) {
  tree.add(leaf);
  Slider s = cp5.addSlider(field)
    .setId(_leafSliderCounter)
      .setColorForeground(leaf.getColor())
        .setPosition(10, pos)
          .setSize(300, 20)
            .setRange(1, 300)
              .setValue(leaf.getPower());
  pos += 25;

  Integer sliderID = s.getId();
  mapCP5.put(sliderID, leaf);
  _leafSliderCounter ++;
  return leaf;
}

public void controlEvent(CallbackEvent event) {
  Slider s = (Slider) event.getController();
  int id = s.getId();
  Leaf l = (Leaf) mapCP5.get(id);
  if (l != null && (event.getAction() == ControlP5.ACTION_BROADCAST)) {
    float amount = s.getValue();
    l.setPower(amount);
  }
}

@Override
public void draw() {
  tree.update();

  view.thickness = thickness;
  view.radius = radius;
  view.startArcAngle = radians(rot);

  background(34, 34, 51);
  view.render(g);

  fill(0);
  textMode(CENTER);
  text(str((int) tree.getPower()), view.center.x-15, view.center.y);
}

