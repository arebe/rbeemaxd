
PImage buff;

void setup() {
  size(200, 200);
  background(0);
  buff = createImage(width, height, RGB);
  
  for(int i = 0; i<width*height; i++){
    buff.pixels[i] =color((constrain(int(random(21)),18,20)-18)*255);
  }
}

void draw() {
  buff.loadPixels();
  for(int i = (width*height)-1; i>width; i--){
    buff.pixels[i] = buff.pixels[i-width];
  }
  for (int i = 0; i<width; i++) {
    buff.pixels[i]=color((constrain(int(random(21)),18,20)-18)*255);
  }
  buff.updatePixels();
  image(buff, 0, 0);
  delay(30);
}

