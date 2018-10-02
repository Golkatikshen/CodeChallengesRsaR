class Food {

    int size;
    PVector position;

    Food(int size) {
        this.size = size;
        this.position = new PVector();
        newPosition();
    }

    void newPosition() {
        this.position.x = ((int) random(width / size)) * size;
        this.position.y = ((int) random(height / size)) * size;
    }

    PVector getPosition() {
        return this.position;
    }

    void draw() {
        fill(255, 0, 0);
        rect(this.position.x, this.position.y, size, size);
    }
}
