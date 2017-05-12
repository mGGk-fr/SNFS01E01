/****************************************************** 
 RetroProcessing Demo
 mGGk 2017
 Quick dirty demo coded for the VIP 2017 Demoparty
*******************************************************/
import ddf.minim.*;

Minim minim;
AudioPlayer player;

//Scene number
int sceneNumber = 1;


//Scene definitions
foregroundScrollers fgs;
starfield sf;
zikCube zc;
commodoreFlag cf;
copperList cl;

int musicPosition;

//Prepare the render
void setup(){
  minim = new Minim(this);
  //Initialising scenes
  fgs = new foregroundScrollers();
  sf = new starfield();
  zc = new zikCube();
  cf = new commodoreFlag();
  cl = new copperList();
  //Set window title
  surface.setTitle("mGGk :: TooMuchByte");
  //Set screen size
  size(1280,720,P3D);
  frameRate(60);
  noCursor();
  player = minim.loadFile("erk_mankind.mp3");
  player.play();
}

//Time to draw
void draw(){
  musicPosition = player.position();
  print(musicPosition+"\n");
  if (musicPosition > 0 && musicPosition < 18700){
     sceneNumber = 1; 
  }
  if(musicPosition > 18700){
     sceneNumber = 2; 
  }
  clear();
  //By the scene number change the render
  switch(sceneNumber){
    case 1:
        zc.display();
        break;
    case 2:
      
  }
  //cl.display();
  zc.display();
  sf.display();
  fgs.display();
  //Always draw the scroller text
}