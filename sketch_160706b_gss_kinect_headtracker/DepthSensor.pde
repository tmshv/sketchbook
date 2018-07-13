class DepthSensor {
    DepthSensor (PApplet app) {
      
    }

    String getName(){
        return "";
    }

    void quit() {

    }

    int getFPS(){
        return 0;
    }

    ArrayList<PVector> getPointCloud(int skip, float factor, float minDepth, float maxDepth){
      ArrayList<PVector> pc = new ArrayList<PVector>();
      return pc;
    }

    int[] getRawDepth(){
        return new int[0];
    }
}