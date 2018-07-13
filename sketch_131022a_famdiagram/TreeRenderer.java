import processing.core.PVector;
import processing.core.PGraphics;
import processing.core.PConstants;

public class TreeRenderer {
  private Tree tree;

  public int thickness = 10;
  public int radius = 100;
  public float startArcAngle = 0;
  public PVector center;

  public TreeRenderer(Tree map) {
    super();
    center = new PVector();
    this.tree = map;
  }

  public void render(PGraphics pg) {
    pg.pushMatrix();
    pg.translate(center.x, center.y);
    
    int w = radius * 2;
    int c = tree.treeColor;
    pg.noStroke();
    pg.fill(c);
    pg.ellipseMode(PConstants.CENTER);
    pg.ellipse(0, 0, w, w);

    //arc
    pg.pushMatrix();
    renderTree(pg, tree, radius + thickness / 2, 0, (float) (Math.PI * 2));
    pg.popMatrix();

    pg.popMatrix();
  }

  public void renderTree(PGraphics g, Tree tree, float radius, float startAngle, float endAngle) {
    g.strokeCap(PConstants.SQUARE);
    g.noFill();

    float totalAngle = endAngle - startAngle;
    float totalPower = tree.getPower();
    float drawStartAngle = startAngle;

    for (ITree t : tree.tree) {
      float relation = t.getPower() / totalPower;

      float angle = totalAngle * relation;
      float drawEndAngle = drawStartAngle + angle;
      float centerAngle = startAngle + angle / 2;

      int w = (int) (radius * 2);
      g.strokeWeight(thickness);
      g.stroke(t.getColor());
      g.arc(0, 0, w, w, drawStartAngle, drawEndAngle);

      if (t instanceof Tree) {
        float branchRadius = radius + thickness;
        renderTree(g, (Tree) t, branchRadius, drawStartAngle, drawEndAngle);
      }

      drawStartAngle = drawEndAngle;

      //            PVector textCoord = view.calcCoord(new PVector(), radius + 20 + thickness / 2);
      //            g.translate(textCoord.x, textCoord.y);
      //            g.rotate(view.angleCenter);
      //            g.stroke(255);
      //            g.text(item.name, 0, 0);
    }
  }
}

