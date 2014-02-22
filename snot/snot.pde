PImage buff;
float exp = 1;
int dir = 0;
float cnt = 0;

void setup() {
  size(600, 600,P3D);
  background(0);
  buff = createImage(width, height, RGB);
  for(int i = 0; i<width*height; i++){
    buff.pixels[i] =color((constrain(int(random(21)),18,20)-18)*255);
  }

}

void draw() {
  //buff.resize(width, height);
  buff.loadPixels();
  for(int i = (int(width*exp)*int(height*exp))-1; i>width*exp; i--){
    buff.pixels[i] = buff.pixels[int(i-width*exp)];
  }
  for (int i = 0; i<width*exp; i++) {
    buff.pixels[i]=color((constrain(int(random(21)),18,20)-18)*255);
  }
  buff.updatePixels();
  
  //only increases and returns to zero, no going smaller...
  if(exp < 1.1 && dir == 0){
    exp += 0.01;
  }
  else if(exp >= 1.1){
    exp = 0.01;    
  }
  buff.resize(int(width*exp), int(height*exp));
  translate(width/2, height/2);
  rotate(cnt);
  cnt += constrain(map(mouseX, 0, width, 0.01, 0.1), 0.01, 0.1);
  image(buff, 0, 0);
  delay(30);
}

