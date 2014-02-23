PImage buff;
float exp = 0.01;
int dir = 0;
float cnt = 0;


PGraphics pg;
void setup() {
  size(600, 600, P3D);
  pg = createGraphics(600, 600, P2D);
  pg.beginDraw();
  pg.background(0);
  pg.endDraw();
  background(0);
  buff = createImage(width, height, RGB);
  for (int i = 0; i<width*height; i++) {
    // buff.pixels[i] =color((constrain(int(random(21)),18,20)-18)*255);
  }
}

//space tooth paste

void draw() {
  pushMatrix();
  pg.beginDraw();
  buff.loadPixels();
  for (int i = (int(width*exp)*int(height*exp))-1; i>width*exp; i--) {
    buff.pixels[i] = buff.pixels[int(i-width*exp)];
  }
  for (int i = 0; i<width*exp; i++) {
    buff.pixels[i]=color((constrain(int(random(21)), 18, 20)-18)*255);
  }
  buff.updatePixels();

  if (exp < 1.1 && dir == 0) exp += 0.001;
  else if (exp >= 1.1)exp = 0.01;
  cnt += map(mouseX, 0, width, 0.005, 0.1);
  
  buff.resize(int(width*exp), int(height*exp));
  pg.translate(width/2, height/2);
  pg.rotate(cnt);
  imageMode(CORNER);
  pg.image(buff, 0, 0);

  pg.endDraw();
  popMatrix();

  translate(width/2, height/2);
  rotate(-cnt);
  imageMode(CENTER);
  image(pg, 0, 0);

  delay(10);
}

