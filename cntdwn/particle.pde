/* adapted from Shiffman's Nature of Code */

class ParticleSystem{
  ArrayList<Particle> particles;
  ArrayList<Node> nodes;
  int nParticles=3000;
  float rInit;
  float mNode = 10;

  
  ParticleSystem(PVector l, float r){
    rInit = r;  
    nodes = new ArrayList();
    particles = new ArrayList();
  }
  
  void addNode(PVector l){
    nodes.add(new Node(l, mNode));
    for(int i = 0; i < nParticles; i++){
      addParticle(l);
    }
  }
  
  void addParticle(PVector l){
    float theta = random(-TWO_PI, TWO_PI);
    PVector start = new PVector(l.x + rInit*cos(theta), l.y + rInit*sin(theta));
    particles.add(new Particle(start,int(random(nParticles))));
  }
  
  void updateNode(PVector l, int i){
    // update a node's loc
    Node n = nodes.get(i);
    n.update(l);
  }
    
  
  void updateParticles(){
    // update particle loc
    for (int j = 0; j < nodes.size(); j++){
      Node n = nodes.get(j);
      for (int i = 0; i < particles.size(); i++){
        Particle p = particles.get(i);
        PVector force = n.attract(p);
        p.applyForce(force);
        p.update();
      }   
    }
  }
  
  void display(int mx, int my){
    for (int i = 0; i < particles.size(); i++){
      Particle p = particles.get(i);
      Particle b = particles.get(p.budy);
      strokeWeight(3);
      stroke(i%100, 100, 100);
      point(p.getLoc().x, p.getLoc().y);
      if(abs(p.getLoc().x - mx) < 10 && abs(p.getLoc().y - my) < 10){
        strokeWeight(1);
        line(p.getLoc().x,p.getLoc().y,b.getLoc().x,b.getLoc().y);
      }
    }
    /*** for debugging porpoises *************/
    for (int j = 0; j < nodes.size(); j++){
      Node n = nodes.get(j);
      stroke(255, 0, 0);
      strokeWeight(4);
      point(n.getLoc().x, n.getLoc().y);
    }
    /****************************************/
  }
}

class Particle{
  PVector loc;
  PVector vel;
  PVector acc;
  float mass = 0.1;
  float iniV = 0.2;
  
  int budy = 0;
  
  Particle(PVector l, int b){
    loc = l.get();
    vel = new PVector(random(-iniV, iniV), random(-iniV, iniV));
    acc = new PVector(0,0);
    budy = b;
   }
  
  PVector getLoc(){
    return loc;
  }
  
  void update(){
    //vel.add(acc);
    loc.add(vel);
  }
  void applyForce(PVector force){
    // originally: 
    // acc.add(force);
    vel.add(force);
  }
}

// node will be attraction points in the particle system
class Node{
  PVector loc;
  float mass;
  float G;
  
  Node(PVector l, float m){
    loc = l.get();
    mass = m;
    G = 0.000000675;
  }
  
  void update(PVector l){
    loc = l.get();
  }
  
  PVector getLoc(){
    return loc;
  }
  
  PVector attract(Particle p){
    PVector f = PVector.sub(loc, p.loc);
    float dist = f.mag();
    //dist = constrain(dist, 1.0, width*2); // limit 
    f.normalize();
    // original, inverse proportion to dist:
    //float strength = (G * p.mass * mass) / (dist * dist);
    // directly proportional to dist:
    float strength = (G * p.mass * this.mass) * dist;
    f.mult(strength);
    return f;
  }
}
