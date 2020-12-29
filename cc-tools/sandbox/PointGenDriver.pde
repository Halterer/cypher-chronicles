final float EPSILON = 0.000001;

class PointGenDriver {
    ArrayList<Point> points;
    EdgeSet edges;
    
    public PointGenDriver() {
        this.points = new ArrayList<Point>();
    }
    
    public void genGrid(int layers, float distance) {
        this.genPoints(layers, distance);
        this.genEdges();
    }
    
    private void genPoints(int layers, float distance) {
        // Start with the central point
        PVector center = new PVector(width / 2, height / 2);
        this.createPoint(center);
        
        // Create the rings
        for (int layer = 1; layer < layers; layer++) {
            PVector firstPos = null;
            PVector previousPos = null;
            for (int arm = 0; arm < 7; arm++) {
                float angle = arm * -PI / 3.0;
                PVector currentPos = new PVector();
                currentPos.x = cos(angle) * distance * layer;
                currentPos.y = sin(angle) * distance * layer;
                if (previousPos == null) {
                    // Create and store the first point
                    firstPos = currentPos;
                } else {
                    PVector path = PVector.sub(currentPos, previousPos);
                    for (int offset = 1; offset < layer; offset++) {
                        PVector pointPos = PVector.add(PVector.add(center, previousPos), PVector.mult(path, ((float) offset) / ((float) layer)));
                        createPoint(pointPos);
                    }
                }
                if (arm < 6) {
                    createPoint(PVector.add(center, currentPos));
                }
                previousPos = currentPos;
            }
        }
    }
    
    private void genEdges() {
        this.edges = new EdgeSet(this.points.size());
        
        for (int i = 0; i < this.points.size(); i++) {
            
        }
    }
    
    private void createPoint(PVector pos) {
        int id = this.points.size();
        Point point = new Point(pos, id);
        this.points.add(point);
    }
    
    public void render() {
        for (Point p : this.points) {
            p.render();
        }
        this.edges.render();
    }
}
