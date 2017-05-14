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
   
   void render(){
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
   
   void display(){
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