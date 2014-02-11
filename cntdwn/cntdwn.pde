
float fluct = 0.01;
float posX = sin(fluct);
float posY = cos(fluct)/2+0.5;

color rb = color(47, 0, 170);
color md = color(54, 143, 255);

ParticleSystem ps;
PVector origin = new PVector(0, 0);

void setup(){
  colorMode(HSB, 100);
  smooth();
  size(800,400,P3D);
  initPS();
}


void draw(){
  background(0);
  translate(width/2,height/2);
  noStroke();
  
  fluct+=0.01;
  
  posY = sin(fluct);
  posX = cos(fluct)/2+0.5;
  
  fill(rb);
  ellipse(posX*(width/2),posY*(height/2),30,30);
  fill(md);
  ellipse(posX*(-width/2),posY*(height/2),30,30);
  
  drawPS();  
}

void initPS(){
  ps = new ParticleSystem(origin, width/9);
  ps.addNode(new PVector(width/4, 0));
  ps.addNode(new PVector(-width/4 , 0));
}

void drawPS(){
  strokeWeight(2);
  stroke(80, 200, 180);
  ps.updateNode(new PVector(posX*(width/2),posY*(height/2)), 0);
  ps.updateNode(new PVector(posX*(-width/2),posY*(height/2)), 1);
  ps.updateParticles();
  ps.display(mouseX-width/2,mouseY-height/2);
}
