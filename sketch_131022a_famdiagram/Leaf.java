/**
 * Created by tmshv on 10/14/13.
 */
public class Leaf implements ITree {
    public String name;
    public int color;

    @Override
    public float getPower() {
        return this.power;
    }

    public void setPower(float power) {
        this.power = power;
    }

    private float power = 0;

    @Override
    public void update() {

    }

    public Leaf(String name) {
        this.name = name;
    }

    public Leaf(String name, float power) {
        this(name);
        setPower(power);
    }

    @Override
    public String getName() {
        return this.name;
    }

    @Override
    public int getColor() {
        return this.color;
    }

    public Leaf(String name, float power, int color) {
        this(name, power);
        this.color = color;
    }
}
