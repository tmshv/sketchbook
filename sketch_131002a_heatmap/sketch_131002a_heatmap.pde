/*
* Make It (makeitcenter.com) > CQ Polygraphmash Workshop > Roman Timashev (roman@tmshv.ru)
* Date::2013 [late]
* heat map for: [ 400.0, 400.0 ]
* graph contains nodes: 4167
* @lib: ControlP5 (http://www.sojamo.de/libraries/controlP5/)
* @lib: Mesh (http://www.leebyron.com/else/mesh/)
* This code is licensed under the MIT license. (http://opensource.org/licenses/MIT)
*/

import megamu.mesh.*;
import controlP5.*;

ControlP5 cp5;
CheckBox checkbox;
Range range;

ArrayList<PVector> coords;
float[] lengths;
float maxLength;
PImage map;
Voronoi myVoronoi;

PVector baseCoord;

void setup(){
	size(750, 750);
	baseCoord = new PVector(400, 400);
	map = loadImage("map.png");
	Table table = loadTable("heatmap2.csv", "header");
	coords = new ArrayList<PVector>();
	coords.add(baseCoord);
	for(TableRow r : table.rows()){
		float x = r.getFloat("x");
		float y = r.getFloat("y");
		coords.add(new PVector(x, y));
	}

	lengths = new float[coords.size()];
	lengths[0] = 0;
	int i = 1;
	for(TableRow r : table.rows()){
		float length = r.getFloat("length");
		lengths[i] = length;
		i ++;
	}
	maxLength = maxLength();

	myVoronoi = new Voronoi(getCoords(coords));

	int pos = 10;
	cp5 = new ControlP5(this);
	range = cp5.addRange("range")
		// disable broadcasting since setRange and setRangeValues will trigger an event
		.setBroadcast(false) 
		.setPosition(10, pos)
		.setSize(500, 20)
		.setHandleSize(20)
		.setRange(0,100)
		.setRangeValues(0,100)
		// after the initialization we turn broadcast back on again
		.setBroadcast(true)
	; pos += 25;
	checkbox = cp5.addCheckBox("checkBox")
		.setPosition(10, pos)
		.setColorLabel(#000000)
		.setSize(25, 25)
		.setItemsPerRow(1)
		.setSpacingColumn(10)
		.setSpacingRow(20)
	; pos += 25;
	checkbox.addItem("heatmap", 1);
	checkbox.addItem("voronoi", 0);
	checkbox.addItem("map", 0);
}

void draw(){
	background(0);
	if(isActive(0)){noStroke(); drawVoronoi(true);}
	if(isActive(1)){stroke(90); strokeWeight(1); drawVoronoi(false);}
	if(isActive(2)) image(map, 0, 0);
	noFill(); stroke(#ffffff); strokeWeight(4); point(baseCoord.x, baseCoord.y);
	// saveFrame("heatmap.png");
}

boolean isActive(int i){
	int n = (int) checkbox.getArrayValue()[i];
	return n > 0;
}

void drawVoronoi(boolean regionColor){
	MPolygon[] myRegions = myVoronoi.getRegions();
	int i=0;
	for(i=0; i < myRegions.length-1; i++){
		float regionLength = lengths[i];
		if(inRange(regionLength)){
			MPolygon poly = myRegions[i];
			float lengthRatio = regionLength / maxLength;
			if(regionColor){
				int regColor = regionLength == 0 ? 0xffffff : lerpColor(#ffffff, #000000, lengthRatio);
				fill(regColor);
			}else noFill();
			float[][] regionCoordinates = poly.getCoords();
			drawRegion(regionCoordinates);
		}
	}
}

void drawRegion(float[][] coords) {
	beginShape();
	for (int i=0; i < coords.length; i++) {
		float [] p = coords[i % coords.length];    
		vertex(p[0], p[1]);
	}
	endShape(CLOSE);
}

void drawCoords(){
	int i = 0;
	for(PVector c : coords){
		float l = lengths[i];
		fill(#ffffff); text(str(l), c.x, c.y);
		i++;
	}
}

boolean inRange(float length){
	float l = length / maxLength;
	float min = range.getArrayValue(0) / 100;
	float max = range.getArrayValue(1) / 100;
	return (l > min && l < max);
}

float[][] getCoords(ArrayList<PVector> coords) {
	float[][] out = new float[coords.size()][2];
	for (int i=0; i < coords.size(); i++) {
		PVector c = coords.get(i);
		out[i][0] = c.x;  
		out[i][1] = c.y;
	}
	return out;
}

float maxLength(){
	float out = 0;
	for(int i=0; i < lengths.length-1; i++){
		float l = lengths[i];
		if(l > out){
			out = l;
		}
	}
	return out;
}
