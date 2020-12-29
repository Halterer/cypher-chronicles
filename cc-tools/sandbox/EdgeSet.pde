class EdgeSet {
    private Edge[][] edgeLookup;
    private ArrayList<Edge> edges;
    
    public EdgeSet(int totalPoints) {
        this.edges = new ArrayList<Edge>();
        this.edgeLookup = new Edge[totalPoints][totalPoints];
        for (int i = 0; i < totalPoints; i++) {
            for (int j = 0; j < totalPoints; j++) {
                this.edgeLookup[i][j] = null;
            }
        }
    }
    
    public Edge getEdge(Point p1, Point p2) {
        return this.edgeLookup[p1.id()][p2.id()];
    }
    
    public void createEdge(Point p1, Point p2) {
        if (this.getEdge(p1, p2) == null) {
            Edge edge = new Edge(p1, p2);
            this.edgeLookup[p1.id()][p2.id()] = edge;
            this.edgeLookup[p2.id()][p1.id()] = edge;
            
            this.edges.add(edge);
        }
    }
    
    public void render() {
        for (Edge e : this.edges) {
            e.render();
        }
    }
}
