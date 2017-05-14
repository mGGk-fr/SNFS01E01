public class copperList{
  copper[] copperArray;
  PVector[] colorVects;

  copperList(int count){
   copperArray = new copper[count];
   //Définition des couleurs des coppers
   colorVects = new PVector[count];
   //Y'a surement a moyen de faire des trucs plus automatique mais la deadline approche on code en dur
   //Genre passer en parametres un tableau de vecteurs pour les couleurs
   colorVects[0] = new PVector(52, 152, 219);
   colorVects[1] = new PVector(241, 196, 15);
   colorVects[2] = new PVector(155, 89, 182);
   colorVects[3] = new PVector(46, 204, 113);
   colorVects[4] = new PVector(192, 57, 43);
   for(int i = 0; i < count; i++){
      copperArray[i] = new copper(40, colorVects[i].x, colorVects[i].y, colorVects[i].z, 130+((40+20)*i));
   }
  }
  void display(){
    for(int i = 0; i < copperArray.length; i++){
      copperArray[i].display();
    }
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
   boolean forward = true;
   
   copper(int cH, float rC, float gC, float bC, int yP){
      copHeight = cH;
      redCol = rC;
      blueCol = bC;
      greenCol = gC;
      yPos = yP;
      stepNumber = copHeight;
      srRC = redCol;
      srBC = blueCol;
      srGC = greenCol;
      renderHandler = createGraphics(1280,cH);
   }
   
   void render(){
     renderHandler.beginDraw();
     renderHandler.clear();
     srRC = redCol;
     srBC = blueCol;
     srGC = greenCol;
     for(int i = 0; i < copHeight; i++){
         //Calcul des couleurs à utiliser
         if(i <= (copHeight/2)-6){
           srRC = srRC+(((255-redCol)/(stepNumber/2)));
           srBC = srBC+(((255-blueCol)/(stepNumber/2)));
           srGC = srGC+(((255-greenCol)/(stepNumber/2)));  
         }else if(i >= (copHeight/2)-6){
           srRC = srRC-(((255-redCol)/(stepNumber/2)));
           srBC = srBC-(((255-blueCol)/(stepNumber/2)));
           srGC = srGC-(((255-greenCol)/(stepNumber/2)));
         }else{
           srRC = 255;
           srBC = 255;
           srGC = 255;
         }
         renderHandler.stroke(srRC, srGC, srBC);
         renderHandler.line(0, i, 1280,i);
     }
     renderHandler.endDraw();
     
   }
   
   void display(){
     render();
     if(yPos+speed+copHeight > 730){
        forward = false;
     }
     if(yPos+speed+copHeight < 130){
        forward = true;
     }
     if(forward == true){
       yPos+=speed;
     }else{
       yPos-=speed; 
     }
     image(renderHandler,0,yPos);
   }
}