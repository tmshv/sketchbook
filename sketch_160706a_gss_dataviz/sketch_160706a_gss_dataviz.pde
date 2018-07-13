import twitter4j.*;
import twitter4j.api.*;
import twitter4j.auth.*;
import twitter4j.conf.*;
import twitter4j.json.*;
import twitter4j.management.*;
import twitter4j.util.*;
import twitter4j.util.function.*;

import controlP5.*;
import java.util.*;

PImage map;
Table data;

float mapGeoTop = 55.9210489;
float mapGeoBottom = 55.5673328;
float mapGeoLeft = 37.3271109; 
float mapGeoRight = 37.9518651;

float mapScreenWidth;
float mapScreenHeight;

ControlP5 cp5;
CameraControl cc;

TwitterFeed feed;
float feedLat = 55.7431956;
float feedLan = 37.6093801;
float feedRadius = 1;
String feedRadiusUnit = "km";

ArrayList<ArrayList<String>> tweets;

void setup() {
    fullScreen(P3D);

    map = loadImage("moscow_center-50.png");
    data = loadTable("post_1.csv");

    mapScreenWidth = map.width;
    mapScreenHeight = map.height;

    imageMode(CENTER);

    cp5 = new ControlP5(this);      
    cc = new CameraControl(20, 20);

    feed = new TwitterFeed();

    thread("refreshTweets");
}

void draw() {
    background(0);
    cc.update();

    pushMatrix();
    translate(width/2, height/2, -200);
    rotateX(radians(cc.rotX));
    rotateZ(radians(cc.rotZ));
    translate(0, 0, cc.posZ);
    image(map, 0, 0);

    translate(-(mapScreenWidth/2), -(mapScreenHeight/2), 5);

    // PVector m = geoToPixel(new PVector(37.6440647, 55.7844377));
    PVector m = geoToPixel(new PVector(37.6093801, 55.7431956));

    noStroke();
    fill(255, 0, 0);
    ellipse(m.x, m.y, 10, 10);

    stroke(255, 255, 0);
    strokeWeight(3);
    line(m.x, m.y, 0, m.x, m.y, 200);

    feed.update();

    popMatrix();
}

void refreshTweets(){
    while(true){
        feed.getNewTweets(feedLat, feedLan, feedRadius, feedRadiusUnit);

        delay(60000);
    }
}

// Converts geographical coordinates into screen coordinates.
// Useful for drawing geographically referenced items on screen.
public PVector geoToPixel(PVector getGeoLocation){
    return new PVector(
        mapScreenWidth*(getGeoLocation.x-mapGeoLeft)/(mapGeoRight-mapGeoLeft),
        mapScreenHeight - mapScreenHeight*(getGeoLocation.y-mapGeoBottom)/(mapGeoTop-mapGeoBottom)
    );
}