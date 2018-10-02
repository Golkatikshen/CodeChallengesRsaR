class Triangle {

    PVector a;
    PVector b;
    PVector c;

    Triangle() {
        this.a = new PVector(random(width), random(height));
        this.b = new PVector(random(width), random(height));
        this.c = new PVector(random(width), random(height));
    }

    void display() {
        noStroke();
        if (isMouseInsideTriangle(a, b, c))
            fill(random(255), random(255), random(255));
        else {
            fill(255);
        }
        triangle(this.a.x, this.a.y, this.b.x, this.b.y, this.c.x, this.c.y);
    }
}
