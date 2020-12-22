class PointGenDriver {
    ArrayList<Point> points;
    
    
    public PointGenDriver() {
        this.points = new ArrayList<Point>();
    }
    
    public void genPoints(int layers, float distance) {
        // Start with the central point
        PVector center = new PVector(width / 2, height / 2);
        this.createPoint(center);
        // Create the rings
        for (int layer = 0; layer < layers; layer++) {
            PVector firstPos = null;
            PVector previousPos = null;
            for (float angle = 0; angle < 2 * PI; angle += PI / 3) {
                
                if (last == null) {
                    // Create and store the first point
                    first = 
                }
                // Project the point
                PVector trans = new PVector();
                trans.x = cos(angle) * distance * layer;
                trans.y = sin(angle) * distance * layer;
                createPoint(PVector.add(center, trans));
            }
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
    }
}
