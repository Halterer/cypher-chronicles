final int WIDTH = 50;
final int HEIGHT = 50;
final int CELL_PIXELS = 25;
final color BACKGROUND_COLOR = color(0);
final color CELL_COLOR = color(255, 0, 0);
final float CHANCE_OF_LIFE = 0.45;
final int CAVE_STEPS = 7;
final int POINT_LAYERS = 10;
final float POINT_DISTANCE = 50;

// ------
int GEN_TYPE = 2;
// 0: cave gen, 1: bubble gen, 2: point gen
// ------

final int SCREEN_WIDTH = WIDTH * CELL_PIXELS;
final int SCREEN_HEIGHT = HEIGHT * CELL_PIXELS;

Cells field;
BubblesDriver bubbles;
PointGenDriver driver;

void settings() {
    size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() {
    field = new Cells(HEIGHT, WIDTH);
    field.initialize(CELL_COLOR, CELL_PIXELS, CHANCE_OF_LIFE);
    bubbles = new BubblesDriver();
    driver = new PointGenDriver();
    driver.genPoints(POINT_LAYERS, POINT_DISTANCE);
}

void draw() {
    background(BACKGROUND_COLOR);
    if (GEN_TYPE == 0) {
        field.render();
    } else if (GEN_TYPE == 1) {
        // Bubble gen
        bubbles.simulate();
        bubbles.render();
    } else if (GEN_TYPE == 2) {
        driver.render();
    }
}

void mouseClicked() {
    if (GEN_TYPE == 0) {
        field.generateCave(CELL_COLOR, CELL_PIXELS, CHANCE_OF_LIFE, CAVE_STEPS);
    } else if (GEN_TYPE == 1) {
        bubbles = new BubblesDriver();
        bubbles.fillBubbles(150, 300, .98);
    } else if (GEN_TYPE == 2) {
        
    }
}
