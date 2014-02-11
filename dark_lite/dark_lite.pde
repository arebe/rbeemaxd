ArrayList<Ray> rays;
int nRays = 20;

int maxDepth = -300;
int lScale = 3;



void setup() {
  size(800, 600, P3D);
  colorMode(HSB, 360, 100, 100); 
  rays = new ArrayList();
  for (int i = 0; i < nRays; i++) {
    rays.add(new Ray(random(360)));
  }
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  rotateX(radians(-140));
  for (int i = 0; i < rays.size(); i++) {
    Ray r = rays.get(i);
    r.update();
    r.display();
  } 
  noStroke();
  fill(0);
  translate(0, 0, 5);
  //ellipse(0, 0, width/5, width/5);
  popMatrix();
}



class Ray {
  float angle;
  float time;
  Ray(float ang) {
    angle = ang;
    time = random(100)/100;
  }

  void update() {
    time += 0.002;
    if (time > 1){
     time = 0;
     angle = random(360);
    } 
  }

  void display() {
    float bl =200*constrain(time*10,0,1); //branch length
    float rt = (time*-1)+1; //reverse time
    pushMatrix();
    rotateZ(radians(angle));
    rotateY(radians((-90*time)+90));
    
    stroke(0, 0, 100-time*100, 80);
    strokeWeight(5);
    line(0,0,bl*rt,0);
    stroke(0, 0, 100-time*100, 175);
    strokeWeight(1);
    line(0,0,bl*rt,0);
    
    
    translate(bl*rt,0);
    branch(bl*time,0,time); //set the branch size
    
    stroke(0, 0, 100-time*100, 80);
    strokeWeight(5);
    branch(bl*time,0, time);
    
    popMatrix();
  }
}

void branch(float x, float y, float t) {
  float split = 0.6;
  float hatch = constrain((t*2)*t, 0, 1);
  x *= split;
  y *= split;
  
    if (x > 5 || y > 5) {
      pushMatrix();
      rotate(split*hatch);
      line(0, 0, 0, x, y, 0);
      translate(x, y);
      branch(x, y, t);
      popMatrix(); 

      pushMatrix(); 
      rotate(-split*hatch);
      line(0, 0, 0, x, y, 0);
      translate(x, y);
      branch(x, y, t);
      popMatrix();
  }
}

