import controlP5.*;

ControlP5 c;  // variable for the button controller
int bgColor = 255; // initial background color
int colourR, colourG, colourB;
boolean doFill = false;
String shape = "Rectangle"; // what shape is selected (default rect)
float startX, startY; // Starting position for dragging
boolean drawing = false; // Flag to track if drawing is in progress

void setup() {
  size(800, 500);
  background(bgColor);
  c = new ControlP5(this);  // create the controller for the program

  createButton("Colour_Green", 0, 0, "colour changed to green");
  createButton("Colour_Blue", 100, 0, "colour changed to blue");
  createButton("Colour_Red", 200, 0, "colour changed to red");
  createButton("No_Colour", 300, 0, "colour cleared");
  createButton("Rectangle", 400, 0, "rectangle created");
  createButton("Triangle", 500, 0, "triangle created");
  createButton("Circle", 600, 0, "circle created");
  createButton("Clear_Screen", 700, 0, "screen cleared");
}

void createButton(String name, int x, int y, final String message) {
  c.addButton(name)
    .setBroadcast(false)
    .setPosition(x, y)
    .setValue(255)
    .setSize(100, 100)
    .setBroadcast(true)
    .plugTo(this, name);
}

void draw() {
  // Check if the mouse is over the buttons bar
  if (mouseY < 100) {
    return;
  }

  // Draw the shape when drawing flag is true
  if (drawing) {
    drawShape(startX, startY, mouseX, mouseY);
  }
}

void setColor(int r, int g, int b, String message) {
  println(message);
  doFill = true;
  colourR = r;
  colourG = g;
  colourB = b;
}

void Colour_Green(int n) {
  setColor(0, n, 0, "colour changed to green");
}

void Colour_Blue(int n) {
  setColor(0, 0, n, "colour changed to blue");
}

void Colour_Red(int n) {
  setColor(n, 0, 0, "colour changed to red");
}

void No_Colour(int n) {
  doFill = false;
  noFill();
  println("Colour Cleared");
}

void drawShape(float x1, float y1, float x2, float y2) {
  pushMatrix(); // Save the current transformation matrix
  if (doFill) {
    fill(colourR, colourG, colourB);
  } else {
    noFill();
  }

  if (shape.equals("Rectangle")) {
    rectMode(CORNERS);
    rect(x1, y1, x2, y2);
  } else if (shape.equals("Triangle")) {
    triangle(x1, y1, x2, y1, (x1 + x2) / 2, y2);
  } else if (shape.equals("Circle")) {
    ellipseMode(CORNER);
    float diameter = dist(x1, y1, x2, y2);
    ellipse(x1, y1, diameter, diameter);
  }

  popMatrix(); // Restore the previous transformation matrix
}

void mousePressed() {
  // Set the starting position when the mouse is pressed
  if (mouseY >= 100) {
    startX = mouseX;
    startY = mouseY;
    drawing = true;
  }
}

void mouseReleased() {
  // Draw the shape and reset the drawing flag when the mouse is released
  if (drawing) {
    drawing = false;
    drawShape(startX, startY, mouseX, mouseY);
  }
}

void Rectangle(int n) {
  shape = "Rectangle";
}

void Triangle(int n) {
  shape = "Triangle";
}

void Circle(int n) {
  shape = "Circle";
}

void Clear_Screen(int n) {
  shape = "";
  background(bgColor);
  println("screen cleared");
}
