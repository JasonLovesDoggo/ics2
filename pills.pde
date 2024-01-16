
void setup() {
  size(1000,600);
  background(0);
  design();
}
  int y = 80;
  int x = 50;
  int spacing = 10;
  int len = 20; 
  
void drawRow() {
  println(y);
  while (x <=(height - 50)) {
    stroke(random(255), random(255), random(255));
    strokeWeight(random(2,6));
    line(x,y,x,y+ len);
    x += spacing;
  }
}
void design() {
  rotate(radians(90));
  translate(000,-1000);
  stroke(0);
  //x = 50;
  while (y <= (width-80)) {
    x = 50;
    drawRow();
    y+= 50;

  }}
