class Cell {
    private color cell_color;
    private boolean alive;
    private boolean next_state;
    private int size;
    
    private final int dieBelow = 3;
    private final int birthAbove = 4;
    
    public Cell(color c, int size, boolean alive) {
        this.cell_color = c;
        this.size = size;
        this.alive = alive;
    }
    
    public boolean alive() {
        return this.alive;
    }
    
    public void render(int x, int y) {
        if (this.alive) {
            fill(this.cell_color);
            rect(x * size, y * size, size, size);
        }
    }
    
    public void step(int neighbors) {
        if (this.alive) {
            if (neighbors < this.dieBelow) {
                this.die();
            } else {
                this.live();
            }
        } else {
            if (neighbors > birthAbove) {
                this.live();
            } else {
                this.die();
            }
        }
    }
    
    private void live() {
        this.next_state = true;
    }
    
    private void die() {
        this.next_state = false;
    }
    
    public void update() {
        this.alive = next_state;
    }
}
