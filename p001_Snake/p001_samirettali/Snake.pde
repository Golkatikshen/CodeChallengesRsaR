class Snake {

    int size;
    int step;
    ArrayList<PVector> body;
    PVector direction;
    int directionCode;

    Snake(int size) {
        this.size = size;
        this.step = 5;
        this.body = new ArrayList<PVector>();
        this.direction = new PVector(1, 0);
        this.directionCode = RIGHT;

        this.body.add(new PVector(((int) random(width / size)) * size, ((int) random(height / size) * size)));
    }

    void reset() {
        this.body = new ArrayList<PVector>();
        this.body.add(new PVector(((int) random(width / size)) * size, ((int) random(height / size) * size)));
    }

    void update() {
        for (int i = body.size() - 1; i > 0; i--) {
            PVector part = body.get(i);
            part.x = body.get(i - 1).x;
            part.y = body.get(i - 1).y;
        }

        PVector head = body.get(0);
        head.x += direction.x * this.size;
        head.y += direction.y * this.size;

        // Wrap if snake crosses boundaries
        if (head.x > width - size)
            head.x = 0;
        else if (head.x < 0)
            head.x = width - size;
        if (head.y > height - size)
            head.y = 0;
        else if (head.y < 0)
            head.y = height - size;

        // Collision detection
        for (int i = 1; i < body.size(); i++) {
            PVector part = body.get(i);
            if (head.x == part.x && head.y == part.y)
                reset();
        }
    }

    void draw() {
        fill(0, 255, 0);
        stroke(0);
        rect(body.get(0).x, body.get(0).y, size, size);
        for (int i = 1; i < body.size(); i++) {
            fill(255);
            // fill(255, 255, 255, 255 / i);
            rect(body.get(i).x, body.get(i).y, size, size);
        }
        noStroke();
    }

    void grow() {
        PVector head = body.get(0);
        PVector newHead = new PVector(head.x + this.direction.x * this.size, head.y + this.direction.y * this.size);
        body.add(0, newHead);
    }

    void setDirection(int keycode) {
        if (keycode == UP && this.directionCode != DOWN) {
            this.direction.x = 0;
            this.direction.y = -1;
            this.directionCode = UP;
        } else if (keycode == DOWN && this.directionCode != UP) {
            this.direction.x = 0;
            this.direction.y = 1;
            this.directionCode = DOWN;
        } else if (keycode == LEFT && this.directionCode != RIGHT) {
            this.direction.x = -1;
            this.direction.y = 0;
            this.directionCode = LEFT;
        } else if (keycode == RIGHT && this.directionCode != LEFT) {
            this.direction.x = 1;
            this.direction.y = 0;
            this.directionCode = RIGHT;
        }
    }

    PVector getPosition() {
        return this.body.get(0);
    }

    int getSize() {
      return this.size;
    }
}
