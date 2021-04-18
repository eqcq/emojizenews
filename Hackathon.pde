String message = "BREAKING NEWS";
float x;
float y;
PFont f;

void setup() {
  size(1920,1080);
  smooth();
  textSize(360);
  textAlign(LEFT, CENTER);
  y = height/3;
  x = width;
}

void draw() {
  background(#003060);
  fill(#FFFF00); 
  f = createFont("Maus",360,true);
  textFont(f);         

  text(message,x,y);
  x=x-8;
  if ( x < -textWidth(message) ) {
    x = width;
  }
}
