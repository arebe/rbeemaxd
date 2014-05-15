/* words */


class Words{
  String quote;
  
  Words(String q){
    quote = q;    
  }
  
  void setQuote(String q){
    quote = q;
  }
  
  String getQuote(){
    return quote;
  }
  
  void displayQuote(){
    fill(0, 0, 0);
    text(quote, width/10, height/15, width-(width/9), height-(height/14));
    
  }
  
  /* other useful things to do with words */
}

