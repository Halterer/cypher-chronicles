class Cells {
    private int grid_height;
    private int grid_width;
    private Cell[][] cells;
    // The cell which represents each cell off the screen
    private Cell edge_cell;

    public Cells(int h, int w) {
        this.grid_height = h;
        this.grid_width = w;
        this.cells = new Cell[h][w];
        this.edge_cell = new Cell(color(0), 0, false);
    }
    
    public void generateCave(color c, int s, float randomize, int steps) {
        this.initialize(c, s, randomize);
        
        for (int i = 0; i < steps; i++) {
            this.step();
        }
    }
    
    public void initialize(color c, int s, float randomize) {
        for (int i = 0; i < this.grid_height; i++) {
            for (int j = 0; j < this.grid_width; j++) {
                this.cells[i][j] = new Cell(c, s, random(1) < randomize);
            }
        }
    }
    
    public void render() {
        for (int i = 0; i < this.grid_height; i++) {
            for (int j = 0; j < this.grid_width; j++) {
                this.cells[i][j].render(i, j);
            }
        }
    }
    
    public void step() {
        // First each cell calculates its next value
        for (int i = 0; i < this.grid_height; i++) {
            for (int j = 0; j < this.grid_width; j++) {
                // Count the number of neighboring cells
                int neighbors = 0;
                for (int k = -1; k <= 1; k++) {
                    for (int l = -1; l <= 1; l++) {
                        if (k != 0 || l != 0) {
                            if (get_cell(i + k, j + l).alive()) {
                                neighbors++;
                            }
                        }
                    }
                }
                this.cells[i][j].step(neighbors);
            }
        }
        // Then all cells update at once
        for (int i = 0; i < this.grid_height; i++) {
            for (int j = 0; j < this.grid_width; j++) {
                this.cells[i][j].update();
            }
        }
    }
    
    private Cell get_cell(int row, int column) {
        if (row < 0 || row >= grid_height || column < 0 || column >= grid_width) {
            return this.edge_cell;
        } else {
            return this.cells[row][column];
        }
    }
}
