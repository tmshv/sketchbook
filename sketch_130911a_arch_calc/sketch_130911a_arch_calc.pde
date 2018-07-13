/*
* SPbGASU::Architecture::1a5::Roman Timashev (roman@tmshv.ru)
* The Sketch is licensed under the MIT license. (http://opensource.org/licenses/MIT)
*/
import controlP5.*;
import processing.pdf.*;

ControlP5 cp5;

int population;
float personArea;
float territoryArea;
float buildindAreaPercent;
float sectionArea;
float sectionLivingAreaPercent;

float buildingArea;
float sectionLivingArea;
float totalLivingArea;
int totalSections;

float zoomFactor = 0.015;

void setup(){
  fullScreen();
	//size(800,500);

	int pos = 10;
	cp5 = new ControlP5(this);
	cp5.addSlider("population")
		.setPosition(10, pos)
		.setSize(200, 20)
		.setRange(1, 3000)
		.setValue(1250);
	pos += 25;
	cp5.addSlider("personArea")
		.setPosition(10, pos)
		.setSize(200, 20)
		.setRange(1, 100)
		.setValue(30);
	pos += 25;
	cp5.addSlider("territoryArea")
		.setPosition(10, pos)
		.setSize(200, 20)
		.setRange(0.5, 10)
		.setValue(5);
	pos += 25;
	cp5.addSlider("buildindAreaPercent")
		.setPosition(10, pos)
		.setSize(200, 20)
		.setRange(1, 100)
		.setValue(20);
	pos += 25;
	cp5.addSlider("sectionArea")
		.setPosition(10, pos)
		.setSize(200, 20)
		.setRange(1, 1000)
		.setValue(450);
	pos += 25;
	cp5.addSlider("sectionLivingAreaPercent")
		.setPosition(10, pos)
		.setSize(200, 20)
		.setRange(1, 100)
		.setValue(90);
}

void draw(){
	background(204);
	calc();

	float radius;
	int w;

	pushMatrix();
		translate(500, 150);
		int textPos = 0;

		radius = calcRadius(gaToQuadMeters(territoryArea)) * zoomFactor;
		w = int(radius * 2);
		noStroke(); fill(#32da35); ellipseMode(CENTER); ellipse(0, 0, w, w);
		fill(#ffffff); text(str(gaToQuadMeters(territoryArea)), radius+10, textPos);
		textPos += 15;

		radius = calcRadius(buildingArea) * zoomFactor;
		w = int(radius * 2);
		noStroke(); fill(#bd3235); ellipseMode(CENTER); ellipse(0, 0, w, w);
		fill(#ffffff); text(str(buildingArea), radius+10, textPos);
		textPos += 15;
		popMatrix();

	pushMatrix();
		translate(200, 300);
		int columns = 10;
		float sectionSize = sqrt(sectionArea);
		ArrayList<Building> bList = createBuildings();
		int i = 0;
		for(Building b : bList){
			int r = floor(i / columns);
			int c = i - (r * columns);
			int x = int(c * (sectionSize + 25));
			int y = int(r * (sectionSize + 25));

			pushMatrix();
				for(int f = 0; f < b.floorCount; f ++){
					stroke(#cccccc); fill(#dddddd); rect(x, y, sectionSize, sectionSize);
					translate(4, 4);
				}
				fill(#ffffff); text(str(b.floorCount), x+3, y+10);
				popMatrix();
			i ++;
		}
		popMatrix();
}

void calc(){
	buildingArea = gaToQuadMeters(territoryArea) * (buildindAreaPercent/100f);
	sectionLivingArea = sectionArea * (sectionLivingAreaPercent/100f);
	totalLivingArea = population * personArea;
	totalSections = int(totalLivingArea / sectionLivingArea);
}

float calcRadius(float area){
	return area / (2*PI);
}

ArrayList<Building> createBuildings(){
	ArrayList<Building> list = new ArrayList<Building>();
	int buildingCount = int(buildingArea / sectionArea);

	for(int i = 0; i < buildingCount; i++){
		Building b = new Building();
		list.add(b);	
	}

	int fillSectionsCount = totalSections - buildingCount;
	for(int i = 0; i < fillSectionsCount; i++){
		int index = i % buildingCount;
		Building b = list.get(index);
		b.addFloor();
	}
	return list;
}

float gaToQuadMeters(float ga){
	return ga * 10000;
}

void keyPressed(){
  if(key == 'q'){
    noLoop();
    beginRecord(PDF, "calc.pdf");
    draw();
    endRecord();
    loop();
  }
}

class Building{
	public int floorCount = 1;

	public Building(){

	}

	public void addFloor(){
		floorCount ++;
	}
}