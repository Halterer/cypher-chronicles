final int POINT_DIAMETER = 15;

class Point {
    PVector position;
    int id;
    
    public Point(PVector position, int id) {
        this.position = position;
        this.id = id;
    }
    
    public void render() {
        fill(#C0C0C0);
        ellipse(this.position.x, this.position.y, POINT_DIAMETER, POINT_DIAMETER);
    }
}
