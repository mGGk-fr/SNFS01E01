public class foregroundScrollers{
  PFont fontBottom;
  float sineFreq = .10;
  float red, blue, green;
  int roundTop = 1;
  int roundBottom = 1;
  String scrollerText;
  int textPosX = 1280;
  //Constructeur
  foregroundScrollers(){
     fontBottom = loadFont("fontBottom.vlw");
     scrollerText = "Yeah !!!! Another release from mGGk, this time a small PC intro for the VIP 2017 Demoparty called TooMuchByte.";
     scrollerText += " This is a dirty quick intro made in processing to take part in the competition - First a full vectored cube..........why ? because it's nice :)";
     scrollerText += " Greetz to groups I like : ASD - Brainstorm - PooBrain - Cocoon - Conspiracy - Resistance - Mandarine - Fairlight - LNX - Triple A - Popsy Team - TRSI - X-Men - FLC - Flush - Still - Razor 1911";
  }
  void display(){
    
    //Top back square
    noStroke();
    fill(0);
    rect(0,0,1280,50);
    //Top rainbow squares
    for(int i = 2; i < 258; i++){
      red = sin(sineFreq*(i-roundTop) + 0) * 127+128;
      blue = sin(sineFreq*(i-roundTop) + 2) * 127+128;
      green = sin(sineFreq*(i-roundTop) + 4) * 127+128;
      fill(red,green,blue);
      rect((i-2)*5,50,5,5);
    }
    roundTop+=2;
    
    //Bottom rainbow squares
    fill(0);
    rect(0,670,1280,50);
    for(int i = 2; i < 258; i++){
      red = sin(sineFreq*(i-roundBottom) + 0) * 127+128;
      blue = sin(sineFreq*(i-roundBottom) + 2) * 127+128;
      green = sin(sineFreq*(i-roundBottom) + 4) * 127+128;
      fill(red,green,blue);
      rect((i-2)*5,665,5,5);
    }
    roundBottom+=2;
    
    //Font du haut
    fill(255);
    textFont(fontBottom, 24);
    text(scrollerText, textPosX, 32);
    textPosX -=5;
    //Font du bas
    fill(255);
    textFont(fontBottom, 24);
    text("mGGk-2017", 10, 705);
  }
}