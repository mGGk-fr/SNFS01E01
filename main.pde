/****************************************************** 
 RetroProcessing Demo
 mGGk 2017
 Quick dirty demo coded for the VIP 2017 Demoparty
*******************************************************/
import ddf.minim.*;

Minim minim;
AudioPlayer player;
//Pour gérer le plein écran
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
void setup(){
  //size(1280,800,P3D); 
  fullScreen(P3D);
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
void draw(){
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