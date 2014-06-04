/* words */


class Words{
  String quote;
  color wColor = color(0, 0, 0);
  
  Words(String q){
    quote = q;    
  }
  
  void setQuote(String q){
    quote = q;
  }
  
  String getQuote(){
    return quote;
  }
  
  //pass a buffer
  void displayQuote(){
    fill(42);
    text(quote, width/10, height/15, width-(width/9), height-(height/14));    
  }
  
  PGraphics writeQuote(PGraphics p){
    p.fill(0);
    p.textFont(font, 30);
    p.text(quote, width/10, height/15, width-(width/9), height-(height/14)); 
    return p;   
  }

  void spiralQuote(){
    ArrayList<PhiSpiral> spirals = new ArrayList<PhiSpiral>();
    for(int i = 0; i < 8; i++){
      // spiral params: a, theta incr, # turns, line/dot
      spirals.add(new PhiSpiral(i*3, 10, 5, "letters"));
      spirals.get(i).display(wColor, quote);
    }
  }
  
  /* other useful things to do with words */
}
