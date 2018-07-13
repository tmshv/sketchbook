class DepthSensorDummy extends DepthSensor {
  ArrayList<PVector> points;

  public DepthSensorDummy (PApplet app) {
    super(app);
    points = new ArrayList<PVector>();

    float s = 150;
    for(int i = 0; i<2500; i++){
      float x = random(-s, s) - 200;
      float y = random(-s, s);
      float z = random(-s, s);

      points.add(new PVector(x, y, z));
    }

    for(int i = 0; i<2500; i++){
      float x = random(-s, s) + 200;
      float y = random(-s, s);
      float z = random(-s, s);

      points.add(new PVector(x, y, z));
    }
  }

  String getName(){
    return "Dummy";
  }

  void quit() {

  }

  int getFPS(){
      return 0;
  }

  ArrayList<PVector> getPointCloud(int skip, float factor, float minDepth, float maxDepth){
    ArrayList<PVector> ps = new ArrayList<PVector>();
    for (PVector p : points) {
        ps.add(p);
    }

    return ps;
  }

  int[] getRawDepth(){
    return new int[0];
  }
}