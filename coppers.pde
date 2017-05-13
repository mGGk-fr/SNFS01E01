public class copperList{
  copper myCopper;
  
  copperList(){
   myCopper = new copper(50,192,57,43,250); 
    
  }
  void display(){
    myCopper.display();
  }
}

public class copper{
   PGraphics renderHandler;
   int copHeight;
   int yPos;
   float redCol, blueCol, greenCol;
   float srRC, srBC, srGC;
   //Nombre de couleurs différentes avant d'atteinds le blanc
   int stepNumber;
   int maxBot = 5;
   float currentY;
   float minY = 80;
   float maxY = 600;
   int speed = 5;
   
   copper(int cH, float rC, float bC, float gC, int yP){
      copHeight = cH;
      redCol = rC;
      blueCol = bC;
      greenCol = gC;
      yPos = yP;
      stepNumber = copHeight;
      srRC = redCol;
      srBC = blueCol;
      srGC = greenCol;
      renderHandler = createGraphics(1280,50);
   }
   
   void render(){
     renderHandler.beginDraw();
     renderHandler.clear();
     srRC = redCol;
     srBC = blueCol;
     srGC = greenCol;
     for(int i = 0; i < copHeight; i++){
         //Calcul des couleurs à utiliser
         if(i < (copHeight/2)-5){
           srRC = srRC+(((255-redCol)/(stepNumber-5)));
           srBC = srBC+(((255-blueCol)/(stepNumber-5)));
           srGC = srGC+(((255-greenCol)/(stepNumber-5)));  
         }else if(i > (copHeight/2)+5){
           srRC = srRC-(((255-redCol)/(stepNumber-5)));
           srBC = srBC-(((255-blueCol)/(stepNumber-5)));
           srGC = srGC-(((255-greenCol)/(stepNumber-5)));
         }
         renderHandler.stroke(srRC, srBC, srGC);
         renderHandler.line(0, i, 1280,i);
         
     }
     renderHandler.endDraw();
     
   }
   
   void display(){
     render();
     image(renderHandler,0,250);
   }
}