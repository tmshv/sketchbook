import java.util.ArrayList;

public class Tree implements ITree {
	public String name;
    public int treeColor;

    private float power;
    @Override
    public float getPower() {
        return power;
    }

	public ArrayList<ITree> tree;

	public Tree() {
        tree = new ArrayList<ITree>();
    }

    public Tree(String name) {
        this();
        this.name = name;
    }

    @Override
    public int getColor() {
        return this.treeColor;
    }

    @Override
    public String getName() {
        return this.name;
    }

    public Tree(String name, int color) {
        this(name);
        this.treeColor = color;
    }

    public void update() {
        float p = 0;
        for (ITree t : tree) {
            t.update();
            p += t.getPower();
        }
        power = p;
    }

    public ITree add(ITree data) {
        tree.add(data);
        return data;
    }
}
