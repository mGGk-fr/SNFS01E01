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
  
  void display(){
    for(int i = 0; i< stars.length; i++){
       stars[i].display(); 
    }
  }
  
}

//Classe qui genere les étoiles

public class Star{
  //Variables de position
  float x;
  float y;
  
  Star(){
     //La position en Y est random
     y = random(0, height);
     //La position en X est random aussi au départ
     x = random(0, width);
  }
  
  void display(){
     x -= 10;
     if(x <= 0){
        x = width+random(0,width);
     }
     fill(255);
     noStroke();
     rect(x,y,2,2);
  }
}