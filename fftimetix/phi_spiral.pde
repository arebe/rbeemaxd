class PhiSpiral{
  // mathematical constants
  float e = 2.71828182845904523536; // euler's number
  // http://en.wikipedia.org/wiki/Golden_spiral
  //float c = 1.358456; // use for rad
  float c = 1.0053611; //for deg
  
  float a, thetaIncr, nTurns;
  boolean line, dot, letters;
  
  // spiral params: a, theta incr, # turns, line/dot
  PhiSpiral(int x, int ti, int n, String ld){
    a = x;
    thetaIncr = ti;
    nTurns = n;
    // line/dot determines how the spiral will be displayed
    if (ld == "line"){
      line = true;
      dot=false;
    }
    else if (ld == "dot"){
      line = false;
      dot = true;
    }
    else if (ld =="linedot"){
      line = true;
      dot = true;
    }
    else if (ld =="letters"){
      line = false;
      dot = false;
      letters = true;
    }
  }
  
  void display(color lineColor, String words){
    float[] coord = new float[2];
    float[] oldCoord = new float[2];
    float r;
    int windex = 0;
    for(float theta = 0; theta < nTurns*360; theta += thetaIncr){
      r = a * pow(c, theta);
      oldCoord = coord;
      coord = polarToCartesian(r, theta);
      pushMatrix();
      translate(width/2, height/2);
      if (line){
        stroke(lineColor, 200);
        strokeWeight(3);
        line(oldCoord[0], oldCoord[1], coord[0], coord[1]);
      }
      if (dot){
        stroke(lineColor);
        strokeWeight(5);
        point(coord[0], coord[1]);
      }
      if(letters){
        fill(lineColor);
        strokeWeight(3);
        text(words.charAt(windex), coord[0], coord[1]);
        if(windex < words.length()-1){
          windex++;
        }
        else{
          windex = 0;
        }
      }
      popMatrix();
    }
  }
    
  float[] polarToCartesian(float r, float a){
    float x = r * cos(radians(a));
    float y = r * sin(radians(a));
    float[] cart = {x, y};
    return cart;
  }
     
}
