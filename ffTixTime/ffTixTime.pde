/* ticket time */

/* libs */

/* globals */

/* MaxD */
//dunno if its just my graphicCard, but the font rendering dosent look super on my system :/


//int dimFactor = 300; // for print
int dimFactor = 150;  // for development

ArrayList<Words> words;

PFont font;

PGraphics mask;

int selectedQuote = 0;

/* setup */
void setup(){
  size(3*dimFactor, 4*dimFactor);
  smooth();//does it help?
  colorMode(HSB, 360, 100, 100);
  background(0,0,100);
  //font = loadFont("Skia-Regular_Light-Condensed-48.vlw");
  font = loadFont("ChumblyBRK-48.vlw");
  textFont(font, 30);
  words = new ArrayList<Words>();
  words.add(new Words("Let us admit that we have attended parties where for one brief night a republic of gratified desires was attained. Shall we not confess that the politics of that night have more reality and force for us than those of, say, the entire U.S. Government? Some of the 'parties' we've mentioned lasted for two or three years. Is this something worth imagining, worth fighting for? Let us study invisibility, webworking, psychic nomadism--and who knows what we might attain? —Hakim Bey TAZ"));
  words.add(new Words("Anyone who can read history with both hemispheres of the brain knows that a world comes to an end every instant--the waves of time leave washed up behind themselves only dry memories of a closed & petrified past--imperfect memory, itself already dying & autumnal. And every instant also gives birth to a world--despite the cavillings of philosophers & scientists whose bodies have grown numb--a present in which all impossibilities are renewed, where regret & premonition fade to nothing in one presential hologrammatical psychomantric gesture.  — Hakim Bey TAZ"));
  words.add(new Words("Provided we can escape from the museums we carry around inside us, provided we can stop selling ourselves tickets to the galleries in our own skulls, we can begin to contemplate an art which re-creates the goal of the sorcerer: changing the structure of reality by the manipulation of living symbols ... Art tells gorgeous lies that come true. — Hakim Bey TAZ"));
  words.add(new Words("Our revolution must be an immediate revolution in our daily lives; anything else is not a revolution, but a demand that people once again do what they do not want to do and hope that that this time, somehow, the compensation will be enough. — DOWNOL"));
  words.add(new Words("Nothing could be more tragic, and more ridiculous, than to live out a whole life  in reach of heaven without ever stretching out your arms — DOWNOL"));
  fill(0);
  mask = createGraphics(width,height);
}

/* draw loop */
void draw(){
  quoteSelecta();

  //prepare mask
  mask.beginDraw();
  mask.background(1);
  //putt quote on mask
  words.get(selectedQuote).writeQuote(mask);
  //process mask
  mask = makeMask(mask);
  mask.endDraw();

  //put art here?
  randomFill();

  image(mask,0,0);
}


void quoteSelecta(){
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
     selectedQuote = i;
   }    
 }
}

/* check mouse position */
boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  else {
    return false;
  } 
}

//find and angle between two coords
float angleCalc(float x, float y, float X, float Y){
  return atan2(y-Y, x-X);
}

//replace all pixels by transparency except a specific color
PGraphics makeMask(PGraphics p){
  p.loadPixels();
  for(int i = 0; i< p.pixels.length; i++){
    //hopefully the color you would like to keep is at pixel 2
    if(p.pixels[i]!=p.pixels[2]) p.pixels[i] = color(0,0,100,0);
  }
  p.updatePixels();
  return p;
}

//return a random color
color randomColor(){
  return color(random(50,255),random(50,255),random(50,255));
}

void randomFill(){
  loadPixels();
  for(int i = 0; i< pixels.length; i++){
    pixels[i] = randomColor();
  }
  updatePixels();
}