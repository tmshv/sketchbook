class Rect{
  public PVector tl;
  public PVector br;
  
  public Rect(PVector tl, PVector br){
    this.tl = tl;
    this.br = br;
  }

  public int getWidth(){
    return (int) abs(tl.x - br.x);
  }

  public int getHeight(){
    return (int) abs(tl.y - br.y);
  }

  public Rect[] splitByPoint(PVector point){
    Rect[] out = new Rect[4];
    out[0] = new Rect(this.tl, point);
    out[1] = new Rect(
      new PVector(point.x, this.tl.y),
      new PVector(this.br.x, point.y)
    );
    out[2] = new Rect(
      new PVector(this.tl.x, point.y),
      new PVector(point.x, this.br.y)
    );
    out[3] = new Rect(point, this.br);
    return out;
  }  
}
