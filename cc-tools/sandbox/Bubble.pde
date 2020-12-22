final float SPRING = 0.01;
final float FRICTION = 0.99;

class Bubble {
    private PVector position;
    private PVector velocity;
    private float diameter;
    
    public Bubble(float x, float y, float diameter) {
        this.position = new PVector(x, y);
        this.velocity = new PVector(0, 0);
        this.diameter = diameter;
    }
    
    void collideWith(Bubble other) {
        float dx = other.x() - this.x();
        float dy = other.y() - this.y();
        float dist = sqrt(dx*dx + dy*dy);
        float minDist = this.radius() + other.radius();
        
        if (dist < this.radius() + other.radius()) {
            float angle = atan2(dy, dx);
            float targetX = this.x() + cos(angle) * minDist;
            float targetY = this.y() + sin(angle) * minDist;
            PVector a = new PVector((targetX - other.x()) * SPRING, (targetY - other.y()) * SPRING);
            this.velocity.sub(a);
            other.velocity().add(a);
        }
    }
    
    void move() {
        this.position.add(velocity);
        
        if (this.x() + this.radius() > width || this.x() - this.radius() < 0) {
            this.velocity.x *= -1;
            this.position.x = this.x() < 0 ? this.radius() : this.x();
            this.position.x = this.x() > width ? width - this.radius() : this.x();
        }
        if (this.y() + this.radius() > height || this.y() - this.radius() < 0) {
            this.velocity.y *= -1;
            this.position.y = this.y() < 0 ? this.radius() : this.y();
            this.position.y = this.y() > height ? height - this.radius() : this.y();
        }
        
        this.velocity.mult(FRICTION);
    }
    
    void render() {
        fill(#C0C0C0);
        ellipse(this.x(), this.y(), this.diameter, this.diameter);
    }
    
    public float x() {
        return this.position.x;
    }
    
    public float y() {
        return this.position.y;
    }
    
    public float radius() {
        return this.diameter / 2.0;
    }
    
    public PVector velocity() {
        return this.velocity;
    }
}
