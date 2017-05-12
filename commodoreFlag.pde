public class commodoreFlag{
    PImage img;
    int round = 1;
    commodoreFlag(){
       //loading commodore flag 
       img = loadImage("commodore-logo.jpg");
    }
    
    void display(){
       for(int x = 0; x < img.width; x++){
          image(img.get(x,0,1,img.height), x, 20*sin(radians(x+(round/10))));
          round++;
        } 
    }
}