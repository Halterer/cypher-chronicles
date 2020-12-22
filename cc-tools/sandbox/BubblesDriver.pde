class BubblesDriver {
    private ArrayList<Bubble> bubbles;
    
    public BubblesDriver() {
        this.bubbles = new ArrayList<Bubble>();
    }
    
    public void fillBubbles(float minDiameter, float maxDiameter, float areaCoverage) {
        float totalArea = 0;
        float targetArea = width * height;
        while (totalArea / targetArea < areaCoverage) {
            Bubble bubble = this.genBubble(minDiameter, maxDiameter);
            totalArea += PI * bubble.radius() * bubble.radius();
        }
    }
    
    public Bubble genBubble(float minDiameter, float maxDiameter) {
        float x = random(width / 3.0, width / 3.0 * 2);
        float y = random(height / 3.0, height / 3.0 * 2);
        float diameter = random(minDiameter, maxDiameter);
        Bubble bubble = new Bubble(x, y, diameter);
        this.bubbles.add(bubble);
        return bubble;
    }
    
    public void simulate() {
        for (int i = 0; i < this.bubbles.size(); i++) {
            for (int j = i; j < this.bubbles.size(); j++) {
                this.bubbles.get(i).collideWith(bubbles.get(j));
                this.bubbles.get(i).move();
            }
        }
    }
    
    public void render() {
        for (Bubble b : this.bubbles) {
            b.render();
        }
    }
}
