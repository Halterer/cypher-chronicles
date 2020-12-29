final float EPSILON = 0.000001;

class PointGenDriver {
    private ArrayList<Point> points;
    private EdgeSet edges;
    private int layers;
    
    public PointGenDriver() {
        this.points = new ArrayList<Point>();
    }
    
    public void genGrid(int layers, float distance) {
        this.layers = layers;
        
        this.genPoints(layers, distance);
        this.genEdges();
    }
    
    private void genPoints(int layers, float distance) {
        // Start with the central point
        PVector center = new PVector(width / 2, height / 2);
        this.createPoint(center);
        
        // Create the rings
        for (int layer = 1; layer < layers; layer++) {
            PVector previousPos = null;
            for (int arm = 0; arm < 7; arm++) {
                float angle = arm * -PI / 3.0;
                PVector currentPos = new PVector();
                currentPos.x = cos(angle) * distance * layer;
                currentPos.y = sin(angle) * distance * layer;
                if (previousPos != null) {
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
        
        // Each point on a multiple of 60deg only connects to 1 point beneath it
        // All other points connect to 2 beneath
        
        for (int layer = 1; layer < this.layers; layer++) {
            for (int offset = 0; offset < 6 * layer; offset++) {
                Point current = this.getPointByOffset(layer, offset);
                
                this.edges.createEdge(current, this.getPointByOffset(layer, offset + 1));
                
                if (layer == 1 || offset % layer == 0) {
                    // This point is on a diagonal
                    int diagonal = (int) offset / layer;
                    Point inner;
                    if (layer != 1) {
                        inner = this.getPointByOffset(layer - 1, diagonal * (layer - 1));
                    } else {
                        inner = this.points.get(0);
                    }
                    this.edges.createEdge(current, inner);
                }
                
                if (layer != 1 && offset % layer != 0) {
                    int diagOffset = offset % layer;
                    int diagonal = floor(offset / layer);
                    // layer - 1, diagonal * (layer - 1) + offset
                    this.edges.createEdge(current, this.getPointByOffset(layer - 1, diagonal * (layer - 1) + diagOffset));
                    this.edges.createEdge(current, this.getPointByOffset(layer - 1, diagonal * (layer - 1) + diagOffset - 1));
                }
            }
        }
        
        print("Edge count: ", this.edges.size());
    }
    
    private Point getPointByOffset(int layer, int offset) {
        int pointsBefore = 1;
        for (int i = 1; i < layer; i++) {
            pointsBefore += 6 * i;
        }
        
        return this.points.get(pointsBefore + (offset % (6 * layer)));
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
