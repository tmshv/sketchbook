public class Cluster{
    ArrayList<PVector> points;

    int fillColor;
    String name;

    private PVector centroid;

    ArrayList<PVector> path;

    int startTime;

    boolean enabled = true;

    public Cluster (String n, int fc, int t) {
        name = n;
        points = new ArrayList<PVector>();
        path = new ArrayList<PVector>();
        fillColor = fc;
        startTime = t;
    }

    Cluster enable(){
        enabled = true;
        return this;
    }

    Cluster disable(){
        enabled = false;
        return this;
    }

    Cluster add(PVector p){
        points.add(p);
        return this;
    }

    Cluster add(ArrayList<PVector> points){
        for (PVector p : points) {
            this.points.add(p);
        }
        return this;
    }

    Cluster write(Cluster otherCluster){
        path.add(otherCluster.getCentroid());
        return this;
    }

    PVector getCentroid(){
        if(centroid != null){
            return centroid;
        }else{
            centroid = new PVector();
            for (PVector p : points) centroid.add(p);
            centroid.div(points.size());
            return centroid;
        }
    }

    float getPathLength(){
        float length = 0;

        if(path.size() > 0){        
            for(int i = 1; i<path.size(); i++){
                PVector p1 = path.get(i - 1);
                PVector p2 = path.get(i);
                length += dist(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
            }
        }
        return length;
    }
}
