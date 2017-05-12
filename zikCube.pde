public class zikCube{
    PGraphics pg;
    float round = 1;
    PImage tex;
    zikCube(){
       pg = createGraphics(1280, 720, P3D);
    }
    void display(){
        tex = loadImage("cube_texture.png");
        pg.beginDraw();
        pg.clear();
        //pg.lights();
        pg.translate(width/2, height/2, 0);
        pg.rotateX(round/2); 
        pg.rotateY(round/2); 
        pg.noStroke();
        //pg.box(160);
        pg.scale(90);
        VertexCube();
        
        pg.endDraw();
        round+=.05;
        image(pg, 0, 0); 
    }
    
    void VertexCube() {
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