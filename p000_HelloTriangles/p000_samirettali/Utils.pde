boolean isMouseInsideTriangle(PVector a, PVector b, PVector c) {
    PVector p = new PVector(mouseX, mouseY);
    double A = triangleArea(a, b, c);
    double A1 = triangleArea(p, b, c);
    double A2 = triangleArea(a, p, c);
    double A3 = triangleArea(a, b, p);

    return ((int) A == (int) (A1 + A2 + A3));
}

double triangleArea(PVector a, PVector b, PVector c) {
    return abs((a.x * (b.y -c.y) + b.x * (c.y - a.y) + c.x * (a.y - b.y)) * 0.5);
}
