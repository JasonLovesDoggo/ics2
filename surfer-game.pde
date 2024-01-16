// Jason Cameron
// Ms. Basaraba
// 2023-10-30
// This program will draw a background of the sky with some seagulls, some sand & the sun along with animating two surfers going across the water.
int beachHeight = 380;
int surferOneX = -60;
int surferTwoX = 860;
int surferSpeed = 3; // variable to control bg refresh

void setup() {
  size(800, 500);
  drawBackground();
}

void drawSun() {
  fill(255, 234, 0);
  noStroke();
  circle(760, 40, 170);
  //fill(224, 208, 25);

  //todo add sunspots
  // todo add texture/triangles or small ellipses to the surface
}

void resetWater() {
    fill(49, 124, 210);
    rect(0, 160, 800, 220);
}

void drawBackground() {
  background(135, 206, 235); // sky 

  resetWater();
  //draw seagulls
  drawSeagull(-30, -60, 25, 0.7);
  drawSeagull(140, -22, -29, 0.5);

  drawSeagull(1600, 25, -20, 0.3); //small ones
  drawSeagull(1800, -55, 20, 0.3); //small ones
  drawSeagull(1730, 55, -40, 0.3); //small ones
  drawSeagull(1820, 120, 40, 0.26); //small ones
  drawSeagull(1620, 180, -40, 0.27); //small ones
  drawSeagull(1750, 225, -40, 0.3); //small ones
  drawSeagull(800, 425, -20, 0.13); //small ones
  
  drawSun();
  
  // draw beach
  fill(194, 178, 128);
  rect(0, beachHeight, 800, 500);
  for (int i=width; i>=0; i-=(10)) {
    int offset = (int)random(-5, 5);
    fill(49, 124, 210);
    ellipse(i, beachHeight+offset, offset*7, 10);
  };
}

void drawSurferOne() {
  int surferLegs = 240;
  fill(214, 245, 172);
  ellipse(surferOneX, surferLegs, 60, 25);
  stroke(0, 0, 0);
  strokeWeight(6);
  //legs
  line(surferOneX-20, surferLegs-20, surferOneX, surferLegs-28);
  line(surferOneX+20, surferLegs-20, surferOneX, surferLegs-28);
  //arms
  line(surferOneX-15, surferLegs, surferOneX, surferLegs-15);
  line(surferOneX+15, surferLegs, surferOneX, surferLegs-15);
  // torso
  strokeWeight(5);
  fill(0, 0, 0); // fill torso (e.g. stomach)
  ellipse(surferOneX, surferLegs - 20, 10, 20);
  //head
  circle(surferOneX, surferLegs - 40, 15);
  fill(255, 255, 255);
  circle(surferOneX-5, surferLegs - 43, 2); // left eye
  circle(surferOneX+5, surferLegs - 43, 2); // right eye
  noStroke();
}
void drawSurferTwo() {
  int surferLegs = 340;
  fill(214, 245, 172);
  ellipse(surferTwoX, surferLegs, 60, 25);
  stroke(0, 0, 0);
  strokeWeight(6);
  //legs
  line(surferTwoX-20, surferLegs-20, surferTwoX, surferLegs-28);
  line(surferTwoX+20, surferLegs-20, surferTwoX, surferLegs-28);
  //arms
  line(surferTwoX-15, surferLegs, surferTwoX, surferLegs-15);
  line(surferTwoX+15, surferLegs, surferTwoX, surferLegs-15);
  // torso
  strokeWeight(5);
  fill(0, 0, 0); // fill torso (e.g. stomach)
  ellipse(surferTwoX, surferLegs - 20, 10, 20);
  //head
  circle(surferTwoX, surferLegs - 40, 15);
  fill(255, 255, 255);
  circle(surferTwoX-5, surferLegs - 43, 2); // left eye
  circle(surferTwoX+5, surferLegs - 43, 2); // right eye
  noStroke();
}

void drawSeagull(int x, int y, int rotate, float scale) {
  noFill();
  stroke(255, 255, 255);
  pushMatrix();
  scale(scale);
  translate(x, y);
  rotate(PI/rotate);
  bezier(120, 80, 150, 80, 150, 110, 150, 110);
  bezier(180, 80, 150, 80, 150, 110, 150, 110);
  strokeWeight(7);
  stroke(175, 110, 20);
  point(150, 110);
  popMatrix();
}

void draw() {
  resetWater();
  drawSun();

  if (surferOneX % (surferSpeed * 10) == 0) { // one update sand every (speed * 10)=30 frames
    drawBackground();
  }

  // surfer one logic
  drawSurferOne();
  surferOneX+=surferSpeed; // add as it starts from negative and is moving right

  // surfer two logic
  drawSurferTwo();

  surferTwoX-=surferSpeed; // subtract as it starts from positive and is moving left
  noStroke();
  if (((surferOneX % (900)) == 0 && surferOneX != 0) ) { // code to reset the animation so it never ends (CAN REMOVE)
    surferOneX = -60;
    surferTwoX = 860;
  }
}