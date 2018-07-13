import org.openkinect.*;
import org.openkinect.processing.*;

class DepthSensorKinect extends DepthSensor{
    Kinect kinect;

    // Size of kinect image
    int w = 640;
    int h = 480;

    float[] depthMeters = new float[2048];

    public DepthSensorKinect (PApplet app) {
      super(app);
      kinect = new Kinect(app);
      kinect.start();
      kinect.enableDepth(true);
      kinect.processDepthImage(false);

      for (int i = 0; i < depthMeters.length; i++) {
        depthMeters[i] = rawDepthToMeters(i);
      }
    }

    String getName(){
        return "Kinect";
    }

    void quit() {
        kinect.quit();
    }

    int getFPS(){
        return (int) kinect.getDepthFPS();
    }

    ArrayList<PVector> getPointCloud(int skip, float factor, float minDepth, float maxDepth){
      int[] depth = getRawDepth();

      ArrayList<PVector> pc = new ArrayList<PVector>();
      for(int x=0; x < w; x += skip) {
        for(int y=0; y < h; y += skip) {
          int offset = x + (y * w);
          int rawDepth = depth[offset];

          // println(rawDepth);
          if(rawDepth > minDepth && rawDepth < maxDepth){
            PVector v = depthToWorld(x, y, rawDepth);
            v.mult(factor);
            v.z = factor - v.z;
            pc.add(v);
          }
        }
      }
      return pc;
    }

    int[] getRawDepth(){
      return kinect.getRawDepth();
    }

    // These functions come from: http://graphics.stanford.edu/~mdfisher/Kinect.html
    float rawDepthToMeters(int depthValue) {
      if (depthValue < 2047) {
        return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
      }
      return 0.0f;
    }

    PVector depthToWorld(int x, int y, int depthValue) {

      final double fx_d = 1.0 / 5.9421434211923247e+02;
      final double fy_d = 1.0 / 5.9104053696870778e+02;
      final double cx_d = 3.3930780975300314e+02;
      final double cy_d = 2.4273913761751615e+02;

      PVector result = new PVector();
      double depth =  depthMeters[depthValue];//rawDepthToMeters(depthValue);
      result.x = (float)((x - cx_d) * depth * fx_d);
      result.y = (float)((y - cy_d) * depth * fy_d);
      result.z = (float)(depth);
      return result;
    }

}