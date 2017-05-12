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
   int copHeight;
   int yPos;
   float redCol, blueCol, greenCol;
   float srRC, srBC, srGC;
   //Nombre de couleurs différentes avant d'atteinds le blanc
   int stepNumber;
   int maxBot = 5;
   
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
   }
   
   void display(){
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
         }else{
         }
         stroke(srRC, srBC, srGC);
         line(0, yPos+i, width,yPos+i);
     }
   }
}