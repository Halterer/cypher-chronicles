final int POINT_DIAMETER = 15;

class Point {
    private PVector position;
    private int id;
    
    public Point(PVector position, int id) {
        this.position = position;
        this.id = id;
    }
    
    public float distanceTo(Point point) {
        return this.position.dist(point.pos());
    }
    
    public void render() {
        fill(#C0C0C0);
        ellipse(this.position.x, this.position.y, POINT_DIAMETER, POINT_DIAMETER);
    }
    
    public int id() {
        return this.id;
    }
    
    public PVector pos() {
        return this.position;
    }
}
