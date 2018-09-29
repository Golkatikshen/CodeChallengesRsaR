Snake snake;
Food food;

int size = 20;

void setup() {
    size(1600, 900);
    frameRate(25);
    noStroke();
    this.snake = new Snake(this.size);
    this.food = new Food(this.size);
}

void draw() {
    background(0);
    this.snake.update();
    PVector snakePosition = this.snake.getPosition();
    PVector foodPosition = this.food.getPosition();
    if (abs(snakePosition.x - foodPosition.x) < size && abs(snakePosition.y - foodPosition.y) < size) {
        this.snake.grow();
        this.food.newPosition();
    }
    this.food.draw();
    this.snake.draw();
    println("Snake position: " + snakePosition.x + " " + snakePosition.y);
    println("Food position: " + foodPosition.x + " " + foodPosition.y);
}

void keyPressed() {
    this.snake.setDirection(keyCode);
}
