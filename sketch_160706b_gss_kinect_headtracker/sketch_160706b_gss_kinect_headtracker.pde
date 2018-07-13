import controlP5.*;
import peasy.*;

DepthSensor depthSensor;

float a = 0;

float factor = 300;
int skip = 10;

PVector cameraPos = new PVector();

float maxDepthTrim;
float minDepthTrim;
float clusteringDist;
int idleTimer;
boolean idleTrim = false;
float pathLengthThreshold;

PeasyCam camera;

float sensorOffsetX = 0;
float sensorOffsetY = 0;
float sensorOffsetZ = 0;

// int idleTimerCounter = 0;

ControlP5 cp5;

boolean moveCamera;

int[] clusterColors = new int[]{#aa0000, #ffff00, #00ff00, #0000aa, #00ffff, #ff00ff};
ArrayList<Cluster> clusters;

void setup() {
  fullScreen(P3D);

  clusters = new ArrayList<Cluster>();

  try{
    depthSensor = new DepthSensorKinect(this);
  }catch(Exception e){
    depthSensor = new DepthSensorDummy(this);
  }

  initUI();

  // camera = new PeasyCam(this, 500);
  // camera.setMinimumDistance(50);
  // camera.setMaximumDistance(1500);

  // camera.setYawRotationMode();   // like spinning a globe
  //camera.setPitchRotationMode(); // like a somersault
  //camera.setRollRotationMode();  // like a radio knob
  //camera.setSuppressRollRotationMode();  // Permit pitch/yaw only.
}

void draw() {
  background(0);
  updateUI();

  pushMatrix();
  translate(width/2, height/2, -20);
  if(moveCamera){
    a = map(mouseX, 0, width, 0, TWO_PI);
  }
  rotateX(sensorOffsetX);
  rotateY(sensorOffsetY);
  rotateZ(sensorOffsetZ);
  rotateY(a);

  ArrayList<PVector> pointCloud = depthSensor.getPointCloud(skip, factor, minDepthTrim, maxDepthTrim);

  colorMode(RGB);
  for(PVector v : pointCloud){
    strokeWeight(1);
    stroke(255);

    point(v.x, v.y, v.z);
  }

  ArrayList<Cluster> frameClusters = getClusters(pointCloud, clusteringDist);

  int minClusterListSize = min(clusters.size(), frameClusters.size());
  for(int i=0; i<minClusterListSize; i++){
    clusters.get(i).write(frameClusters.get(i));
  }

  if(clusters.size() > frameClusters.size()){
    clusters.subList(minClusterListSize, clusters.size()).clear();
  }else if(clusters.size() < frameClusters.size()){
    frameClusters.subList(0, minClusterListSize).clear();
    clusters.addAll(frameClusters);
  }

  int activeClusters = 0;
  for(Cluster cluster : clusters){
    if(idleTrim && (millis() - cluster.startTime) > idleTimer){
      if(cluster.getPathLength() < pathLengthThreshold){
        cluster.disable();
      }
    }

    if(cluster.enabled){
      activeClusters ++;
      PVector v = cluster.getCentroid();

      noFill();
      stroke(cluster.fillColor);
      
      // if(idleTrim){
      strokeWeight(1);
      beginShape();
      for(PVector pathVertex : cluster.path){
        vertex(pathVertex.x, pathVertex.y, pathVertex.z);      
      }
      endShape();
      // }

      strokeWeight(3);    
      point(v.x, v.y, v.z);
      textSize(20);
      text(cluster.name+"-"+cluster.getPathLength(), v.x, v.y, v.z);
    }
  }

  popMatrix();

  fill(255);
  textSize(14);
  text("Depth Sensor: " + depthSensor.getName(), 20, 20);
  text("Kinect FR: " + depthSensor.getFPS(), 20, 40);
  text("Processing FR: " + (int)frameRate, 20, 60);
  text("Clusters: " + activeClusters + "/" + frameClusters.size(), 250, 20);

  pushMatrix();
  drawUI();
  popMatrix();
}

ArrayList<Cluster> getClusters(ArrayList<PVector> points, float maxDistance) {
  ArrayList<Cluster> clusterList = new ArrayList<Cluster>();

  ArrayList<PVector> pointsCopy = new ArrayList<PVector>();
  for (PVector p : points) {
      pointsCopy.add(p);
  }

  for (int i = 0; i < pointsCopy.size();) {
      ArrayList<PVector> clusterPoints = new ArrayList<PVector>();

      for (int j = i + 1; j < points.size();) {
          PVector pi = points.get(i);
          PVector pj = points.get(j);

          float distance = dist(
              pi.x, pi.y, pi.z,
              pj.x, pj.y, pj.z
          );

          if (distance < maxDistance) {
              clusterPoints.add(pi);
              clusterPoints.add(pj);

              points.remove(j);
              pointsCopy.remove(j);
              j = i + 1;
          } else {
              j++;
          }
      }

      if (clusterPoints.size() > 0) {
          int clusterColor = #ffffff;
          if(clusterList.size() < clusterColors.length - 1){
            clusterColor = clusterColors[clusterList.size()];
          }

          int clusterIndex = clusterList.size();
          Cluster cluster = new Cluster(str(clusterIndex), clusterColor, millis());
          cluster.add(clusterPoints);
          clusterList.add(cluster);

          pointsCopy.remove(i);
          points.remove(i);
          i = 0;
      } else {
          i++;
      }
  }
  return clusterList;
}

void keyPressed(){
  if(keyCode == ENTER){
    println(reduceList(depthSensor.getRawDepth(), skip));
  }

  if(keyCode == BACKSPACE){
    clusters = new ArrayList<Cluster>();
  }

  if(keyCode == UP){
    cameraPos.x += 5;
  }

  if(keyCode == DOWN){
    cameraPos.x -= 5;
  }

  if(keyCode == LEFT){
    cameraPos.y += 5;
  }

  if(keyCode == RIGHT){
    cameraPos.y -= 5;
  }
}

void stop() {
  depthSensor.quit();
  super.stop();
}

void initUI(){
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);

  int pos = 100;

  // cp5
  //   .addSlider("sensor-offset-x")
  //   .setLabel("SENSOR OFFSET X")
  //   .setPosition(20, pos)
  //   .setSize(300, 15)
  //   .setRange(0, PI)
  //   .setValue(0)
  // ;
  // pos += 20;
  
  // cp5
  //   .addSlider("sensor-offset-y")
  //   .setLabel("SENSOR OFFSET Y")
  //   .setPosition(20, pos)
  //   .setSize(300, 15)
  //   .setRange(0, PI)
  //   .setValue(0)
  // ;
  // pos += 20;
  
  // cp5
  //   .addSlider("sensor-offset-z")
  //   .setLabel("SENSOR OFFSET Z")
  //   .setPosition(20, pos)
  //   .setSize(300, 15)
  //   .setRange(0, PI)
  //   .setValue(0)
  // ;
  // pos += 20;

  cp5
    .addSlider("max-depth")
    .setLabel("MAX DEPTH")
    .setPosition(20, pos)
    .setSize(300, 15)
    .setRange(0, 2048)
    .setValue(2048)
  ;
  pos += 20;

  cp5
    .addSlider("min-depth")
    .setLabel("MIN DEPTH")
    .setPosition(20, pos)
    .setSize(300, 15)
    .setRange(0, 2048)
    .setValue(0)
  ;
  pos += 20;

  cp5
    .addSlider("clustering-dist")
    .setLabel("CLUSTERING DIST")
    .setPosition(20, pos)
    .setSize(300, 15)
    .setRange(50, 500)
    .setValue(250);
  ;
  pos += 20;

  // cp5
  //   .addCheckBox("idle-trim")
  //   .addItem("TRIM IDLE CLUSTERS", 0)
  //   .setPosition(20, pos)
  //   .setSize(15, 15)
  // ;
  // pos += 20;

  // cp5
  //   .addSlider("idle-timer")
  //   .setLabel("IDLE TIMER")
  //   .setPosition(20, pos)
  //   .setSize(300, 15)
  //   .setRange(500, 5000)
  //   .setValue(1000);
  // ;
  // pos += 20;

  // cp5
  //   .addSlider("path-threshold")
  //   .setLabel("PATH LENGTH THRESHOLD")
  //   .setPosition(20, pos)
  //   .setSize(300, 15)
  //   .setRange(1000, 30000)
  //   .setValue(100);
  // ;
  // pos += 20;

  // cp5
  //   .addCheckBox("display-modes")
  //   .addItem("SHOW CENTROID", 0)
  //   .addItem("SHOW POINTS", 0)
  //   .addItem("SHOW PATH", 0)
  //   .setPosition(20, pos)
  //   .setSize(15, 15)
  // ;
  // pos += 20;
}

int[] reduceList(int[] list, int skip){
  int[] reducedList = new int[0];
  for(int i=0; i < list.length; i += skip) {
    reducedList = append(reducedList, list[i]);
  }
  return reducedList;
}

void drawUI(){
  hint(DISABLE_DEPTH_TEST);
  // camera.beginHUD();
  cp5.draw();
  // camera.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void updateUI(){
  // CheckBox idleTrimCheckBox = (CheckBox) cp5.getController("idle-trim");
  // println(idleTrimCheckBox.getItem(0));

  moveCamera = keyPressed && keyCode == TAB;    

  // sensorOffsetX = cp5.getController("sensor-offset-x").getValue();
  // sensorOffsetY = cp5.getController("sensor-offset-y").getValue();
  // sensorOffsetZ = cp5.getController("sensor-offset-z").getValue();
  maxDepthTrim = cp5.getController("max-depth").getValue();
  minDepthTrim = cp5.getController("min-depth").getValue();
  clusteringDist = cp5.getController("clustering-dist").getValue();
  // idleTimer = (int) cp5.getController("idle-timer").getValue();
  // idleTrim = (int) .getItem(0).getArrayValue()[0] == 1;

  // pathLengthThreshold = cp5.getController("path-threshold").getValue();
}