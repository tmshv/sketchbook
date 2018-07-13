public class CameraControl{
    
    float xpos, ypos;
    float rotX, rotZ;
    float posZ;

    public CameraControl (float x, float y) {
        xpos = x;
        ypos = y;

        cp5
            .addSlider("rotx")
            .setLabel("x rotation")
            .setPosition(x + 20, y + 60)
            .setRange(0, 97)
            .setValue(60)
        ;

        cp5
            .addSlider("rotz")
            .setLabel("z rotation")
            .setPosition(x + 20, y + 100)
            .setRange(0, 360)
            .setValue(0)
        ;

        cp5
            .addSlider("posz")
            .setLabel("z position")
            .setPosition(x + 20, y + 140)
            .setRange(-2000, 2000)
            .setValue(0)
        ;
    }

    void update(){
        rotX = cp5.getController("rotx").getValue();
        rotZ = cp5.getController("rotz").getValue();
        
        posZ = cp5.getController("posz").getValue();
    }
}