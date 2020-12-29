class Edge {
    private Point point1;
    private Point point2;
    private float size;
    
    public Edge(Point p1, Point p2) {
        this.point1 = p1;
        this.point2 = p2;
        this.size = p1.distanceTo(p2);
    }
    
    public void render() {
        stroke(#C0C0C0);
        strokeWeight(4);
        line(point1.pos().x, point1.pos().y, point2.pos().x, point2.pos().y);
    }
}
