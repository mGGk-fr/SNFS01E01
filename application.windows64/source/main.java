import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class main extends PApplet {

/****************************************************** 
 RetroProcessing Demo
 mGGk 2017
 Quick dirty demo coded for the VIP 2017 Demoparty
*******************************************************/


Minim minim;
AudioPlayer player;
//Pour g\u00e9rer le plein \u00e9cran
//Scene number
int sceneNumber = 1;


//Scene definitions
foregroundScrollers fgs;
starfield sf;
zikCube zc;
commodoreFlag cf;
copperList cl;
retroField rf;
boingBall bB;

int musicPosition;
boolean overScene = false;
//Prepare the render
public void setup(){
  //size(1280,800,P3D); 
  
  minim = new Minim(this);
  //Initialising scenes
  fgs = new foregroundScrollers();
  sf = new starfield();
  zc = new zikCube();
  cf = new commodoreFlag();
  cl = new copperList(5);
  rf = new retroField();
  bB = new boingBall();
  //Set window title
  surface.setTitle("mGGk :: RetroProcesing");
  surface.setResizable (false);
  //Set screen size
  
  frameRate(60);
  noCursor();
  player = minim.loadFile("erk_mankind.mp3");
  player.play();
}

//Time to draw
public void draw(){
  musicPosition = player.position();
  print(musicPosition+"\n");
  if (musicPosition > 0 && musicPosition < 16700){
     sceneNumber = 1; 
  }
  if(musicPosition >= 16700 && musicPosition < 25000){
     sceneNumber = 2; 
  }
  if(musicPosition >= 25000 && musicPosition < 30000){
     sceneNumber = 3; 
  }
  if(musicPosition >= 30000 && musicPosition < 65000){
     sceneNumber = 4; 
  }
  if(musicPosition >= 122904){
    exit();
  }
  clear();
  if(overScene == true){
     sceneNumber= 5; 
  }
  //By the scene number change the render
  switch(sceneNumber){
    case 1:
        sf.display();
        zc.display();
        break;
    case 2:
        sf.display();
        cl.display();
        break;
    case 3:
        rf.display();
        break;
    case 4:
        rf.display();
        bB.display();
        break;
  }
  fgs.display();
}
class boingBall{
   PGraphics pg;
   PImage texture;
   PShape ball;
   int round;
   int posX = 0;
   int posY = 0;
   int moveSpeed = 5;
   boolean forwardX, forwardY = true;
   
   
   boingBall(){
       pg = createGraphics(1280,800,P3D);
       texture = loadImage("boing_ball.jpg");
       ball = createShape(SPHERE,20);
       ball.setTexture(texture);
       ball.setStroke(false);
   }
   
   public void render(){
       pg.beginDraw();
       pg.clear();
       pg.noStroke();
       pg.noFill();
       pg.lights();
       pg.translate(width/2, height/2, 0);
       pg.rotateY((round/PI)/10);
       pg.rotateX((round/PI)/10);
       pg.scale(5);
       pg.shape(ball);
       pg.noStroke();
       pg.endDraw();
       round++;
   }
   
   public void display(){
     render();
     if(posX > 530){
        forwardX = false; 
     }
     if(posX < -530){
        forwardX = true; 
     }
     if(posY > 250){
        forwardY = false; 
     }
     if(posY < -250){
        forwardY = true; 
     }
     if(forwardX){
        posX+=moveSpeed; 
     }else{
        posX-=moveSpeed; 
     }
     if(forwardY){
        posY+=moveSpeed; 
     }else{
        posY-=moveSpeed; 
     }
     image(pg,posX,posY);
     
   }
  
}
public class commodoreFlag{
    PImage img;
    int round = 1;
    commodoreFlag(){
       //loading commodore flag 
       img = loadImage("commodore-logo.jpg");
    }
    
    public void display(){
       for(int x = 0; x < img.width; x++){
          image(img.get(x,0,1,img.height), x, 20*sin(radians(x+millis())));
          round++;
        } 
    }
}
public class copperList{
  copper[] copperArray;
  PVector[] colorVects;

  copperList(int count){
   copperArray = new copper[count];
   //D\u00e9finition des couleurs des coppers
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
  public void display(){
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
   //Nombre de couleurs diff\u00e9rentes avant d'atteinds le blanc
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
   
   public void render(){
     renderHandler.beginDraw();
     renderHandler.clear();
     srRC = redCol;
     srBC = blueCol;
     srGC = greenCol;
     for(int i = 0; i < copHeight; i++){
         //Calcul des couleurs \u00e0 utiliser
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
   
   public void display(){
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
public class foregroundScrollers{
  PFont fontBottom;
  float sineFreq = .10f;
  float red, blue, green;
  int roundTop = 1;
  int roundBottom = 1;
  String scrollerText;
  int textPosX = 1280;
  //Constructeur
  foregroundScrollers(){
     fontBottom = loadFont("fontBottom.vlw");
     scrollerText = "Yeah !!!! Another release from mGGk, this time a small PC intro for the VIP 2017 Demoparty called RetroProcessing.";
     scrollerText += " code : mGGk - music : erk^mankind -";
     scrollerText += " First a nice colored cube..........why ? because it's nice :) Oh what's that ? Fake copperbars, it smell AMIGAAAAAAAAAAAAAA ! Well enought of this starfield, let's use a rainbow field.... Whooa nice.... But something from amiga is missing, so let's add a boing ball !";
     scrollerText += " Greetz to groups I like : ASD - Brainstorm - PooBrain - Cocoon - Conspiracy - Resistance - Mandarine - Fairlight - LNX - Triple A - Unity - Popsy Team - farbrausch - TRSI - X-Men - FLC - Flush - Still - Razor 1911";
     scrollerText += "                                                                                                                                                                                                              ";
     scrollerText += "Still there ? Really ? The intro is at the end, go take a beer instead of waiting something....";
  }
  public void display(){
    
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
    rect(0,750,1280,50);
    for(int i = 2; i < 258; i++){
      red = sin(sineFreq*(i-roundBottom) + 0) * 127+128;
      blue = sin(sineFreq*(i-roundBottom) + 2) * 127+128;
      green = sin(sineFreq*(i-roundBottom) + 4) * 127+128;
      fill(red,green,blue);
      rect((i-2)*5,745,5,5);
    }
    roundBottom+=2;
    
    //Font du haut
    fill(255);
    textFont(fontBottom, 24);
    text(scrollerText, textPosX, 32);
    textPosX -=5;
    //print(textPosX+"\n");
    //Font du bas
    fill(255);
    textFont(fontBottom, 24);
    text("mGGk-2017", 10, 785);
  }
}
class retroField{
  PGraphics pg;
  int cols, rows;
  int scl = 20;
  int w = 2000;
  int h = 1600;
  float red, blue, green;
  float sineFreq = .10f;
  float flying = 0;
  int round;
  float[][] terrain;
  
  retroField(){
    pg = createGraphics(1280, 800, P3D);
    cols = w / scl;
    rows = h/ scl;
    terrain = new float[cols][rows];
  }
  
  
  public void display() {
  
    flying -= 0.1f;
  
    float yoff = flying;
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
        xoff += 0.2f;
      }
      yoff += 0.2f;
    }
  
  
    pg.beginDraw();
    pg.background(0);
    for(int i = 2; i < 258; i++){
      red = sin(sineFreq*(i-round/30) + 0) * 127+128;
      blue = sin(sineFreq*(i-round/30) + 2) * 127+128;
      green = sin(sineFreq*(i-round/30) + 4) * 127+128;
      pg.stroke(red,green,blue);
    }
    pg.noFill();
  
    pg.translate(width/2, height/2+50);
    pg.rotateX(PI/3);
    pg.translate(-w/2, -h/2);
    for (int y = 0; y < rows-1; y++) {
      pg.beginShape(TRIANGLE_STRIP);
      for (int x = 0; x < cols; x++) {
        pg.vertex(x*scl, y*scl, terrain[x][y]);
        pg.vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
        //rect(x*scl, y*scl, scl, scl);
      }
      pg.endShape();
    }
    round++;
    pg.endDraw();
    image(pg, 0, 0); 
  } 
}
//Classe qui gere le starfield
public class starfield{
  Star[] stars = new Star[800];
  float speed;
  
  //Constructeur qui initialise les objets
  starfield(){
    for(int i = 0; i < stars.length; i++){
       stars[i] = new Star(); 
    }
  }
  
  public void display(){
    for(int i = 0; i< stars.length; i++){
       stars[i].display(); 
    }
  }
  
}

//Classe qui genere les \u00e9toiles

public class Star{
  //Variables de position
  float x;
  float y;
  
  Star(){
     //La position en Y est random
     y = random(0, height);
     //La position en X est random aussi au d\u00e9part
     x = random(0, width);
  }
  
  public void display(){
     x -= 10;
     if(x <= 0){
        x = width+random(0,width);
     }
     fill(255);
     noStroke();
     rect(x,y,2,2);
  }
}
public class zikCube{
    PGraphics pg;
    float round = 1;
    PImage tex;
    zikCube(){
       pg = createGraphics(1280, 800, P3D);
    }
    public void display(){
        tex = loadImage("cube_texture.png");
        pg.beginDraw();
        pg.clear();
        //pg.lights();
        pg.translate(width/2, height/2, 0);
        pg.rotateX(round); 
        pg.rotateY(round); 
        pg.noStroke();
        //pg.box(160);
        pg.scale(90);
        VertexCube();
        
        pg.endDraw();
        round+=.05f;
        image(pg, 0, 0); 
    }
    
    public void VertexCube() {
      pg.beginShape(TRIANGLES);
      //Cote 2
      pg.fill(0,255,0);
      pg.vertex(-1,-1,-1);
      pg.vertex(1,-1,-1);
      pg.vertex(0,0,-1);
      pg.vertex(1,1,-1);
      pg.vertex(-1,1, -1);
      pg.vertex(0, 0, -1);
      pg.vertex(1,0,0);
      pg.vertex(1,1,1);
      pg.vertex(1,1,-1);
      pg.vertex(1,0,0);
      pg.vertex(1,-1,1);
      pg.vertex(1,-1,-1);
      pg.vertex(-1,-1, 1);
      pg.vertex(1,-1, 1);
      pg.vertex(0,0, 1);
      pg.vertex(1, 1, 1);
      pg.vertex(-1, 1, 1);
      pg.vertex(0,0,1);
      pg.vertex(-1,0,0);
      pg.vertex(-1,1,1);
      pg.vertex(-1,1,-1);
      pg.vertex(-1,0,0);
      pg.vertex(-1,-1,1);
      pg.vertex(-1,-1,-1);
      pg.vertex(0,1,0);
      pg.vertex(1,1,1);
      pg.vertex(1,1,-1);
      pg.vertex(0,1,0);
      pg.vertex(-1,1,1);
      pg.vertex(-1,1,-1);
      pg.vertex(0,-1,0);
      pg.vertex(-1,-1,1);
      pg.vertex(1,-1,1);
      pg.vertex(0,-1,0);
      pg.vertex(-1,-1,-1);
      pg.vertex(1,-1,-1);
      
      pg.fill(255,255,255);
      pg.vertex(-1,-1, -1);
      pg.vertex(-1,1, -1);
      pg.vertex(0, 0, -1);
      pg.vertex(1,1, -1);
      pg.vertex(1,-1,-1);
      pg.vertex(0, 0, -1);
      pg.vertex(1,1,1);
      pg.vertex(1,-1,1);
      pg.vertex(1,0,0);
      pg.vertex(1,0,0);
      pg.vertex(1,1,-1);
      pg.vertex(1,-1,-1);
      pg.vertex(-1,-1,1);
      pg.vertex(-1,1,1);
      pg.vertex(0,0,1);
      pg.vertex(1,1,1);
      pg.vertex(1,-1,1);
      pg.vertex(0,0,1);
      pg.vertex(-1,1,1);
      pg.vertex(-1,-1,1);
      pg.vertex(-1,0,0);
      pg.vertex(-1,1,-1);
      pg.vertex(-1,-1,-1);
      pg.vertex(-1,0,0);
      pg.vertex(0,1,0);
      pg.vertex(-1,1,1);
      pg.vertex(1,1,1);
      pg.vertex(0,1,0);
      pg.vertex(-1,1,-1);
      pg.vertex(1,1,-1);
      pg.vertex(0,-1,0);
      pg.vertex(-1,-1,1);
      pg.vertex(-1,-1,-1);
      pg.vertex(0,-1,0);
      pg.vertex(1,-1,-1);
      pg.vertex(1,-1,1);
      
      pg.endShape();
    }
}
  public void settings() {  fullScreen(P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "main" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
