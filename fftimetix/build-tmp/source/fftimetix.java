import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class fftimetix extends PApplet {

/* ticket time */

/* libs */

/* globals */
//int dimFactor = 300; // for print
int dimFactor = 150;  // for development

ArrayList<Words> words;

PFont font;

/* setup */
public void setup(){
  size(3*dimFactor, 4*dimFactor);
  colorMode(HSB, 360, 100, 100);
  background(0,0,100);
  font = loadFont("Skia-Regular_Light-Condensed-48.vlw");
  textFont(font, 14);
  words = new ArrayList<Words>();
  words.add(new Words("Let us admit that we have attended parties where for one brief night a republic of gratified desires was attained. Shall we not confess that the politics of that night have more reality and force for us than those of, say, the entire U.S. Government? Some of the 'parties' we've mentioned lasted for two or three years. Is this something worth imagining, worth fighting for? Let us study invisibility, webworking, psychic nomadism--and who knows what we might attain? \u2014Hakim Bey TAZ"));
  words.add(new Words("Anyone who can read history with both hemispheres of the brain knows that a world comes to an end every instant--the waves of time leave washed up behind themselves only dry memories of a closed & petrified past--imperfect memory, itself already dying & autumnal. And every instant also gives birth to a world--despite the cavillings of philosophers & scientists whose bodies have grown numb--a present in which all impossibilities are renewed, where regret & premonition fade to nothing in one presential hologrammatical psychomantric gesture.  \u2014 Hakim Bey TAZ"));
  words.add(new Words("Provided we can escape from the museums we carry around inside us, provided we can stop selling ourselves tickets to the galleries in our own skulls, we can begin to contemplate an art which re-creates the goal of the sorcerer: changing the structure of reality by the manipulation of living symbols ... Art tells gorgeous lies that come true. \u2014 Hakim Bey TAZ"));
  words.add(new Words("Our revolution must be an immediate revolution in our daily lives; anything else is not a revolution, but a demand that people once again do what they do not want to do and hope that that this time, somehow, the compensation will be enough. \u2014 DOWNOL"));
  words.add(new Words("Nothing could be more tragic, and more ridiculous, than to live out a whole life  in reach of heaven without ever stretching out your arms \u2014 DOWNOL"));
}

/* draw loop */
public void draw(){
  fill(0, 0, 100);
  strokeWeight(0);
  rect(0, 0, width, height);
  // static buttons
  for(int i = 0; i < words.size(); i++){
    fill(0, 0, 100);
    strokeWeight(5);
    int x = (width/words.size())*i;
    int y =  5;
    int w = width/words.size();
    int h = 15;
    rect(x, y, w, h);
    if(overRect(x, y, w, h)){
      words.get(i).displayQuote();
    }    
  }
  // spiral buttons
  for(int i = 0; i < words.size(); i++){
    fill(0, 0, 100);
    strokeWeight(5);
    int x = (width/words.size())*i;
    int y =  height-20;
    int w = width/words.size();
    int h = 15;
    rect(x, y, w, h);
    if(overRect(x, y, w, h)){
      words.get(i).spiralQuote();
    }    
  }
  
  
  
}

/* check mouse position */
public boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
class PhiSpiral{
  // mathematical constants
  float e = 2.71828182845904523536f; // euler's number
  // http://en.wikipedia.org/wiki/Golden_spiral
  //float c = 1.358456; // use for rad
  float c = 1.0053611f; //for deg
  
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
  
  public void display(int lineColor, String words){
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
    
  public float[] polarToCartesian(float r, float a){
    float x = r * cos(radians(a));
    float y = r * sin(radians(a));
    float[] cart = {x, y};
    return cart;
  }
     
}
/* words */


class Words{
  String quote;
  int wColor = color(0, 0, 0);
  
  Words(String q){
    quote = q;    
  }
  
  public void setQuote(String q){
    quote = q;
  }
  
  public String getQuote(){
    return quote;
  }
  
  public void displayQuote(){
    fill(0, 0, 0);
    text(quote, width/10, height/15, width-(width/9), height-(height/14));
    
  }
  
  public void spiralQuote(){
    ArrayList<PhiSpiral> spirals = new ArrayList<PhiSpiral>();
    for(int i = 0; i < 8; i++){
      // spiral params: a, theta incr, # turns, line/dot
      spirals.add(new PhiSpiral(i*3, 10, 5, "letters"));
      spirals.get(i).display(wColor, quote);
    }
  }
  
  /* other useful things to do with words */
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "fftimetix" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
