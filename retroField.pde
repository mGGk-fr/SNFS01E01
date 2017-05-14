class retroField{
  PGraphics pg;
  int cols, rows;
  int scl = 20;
  int w = 2000;
  int h = 1600;
  float red, blue, green;
  float sineFreq = .10;
  float flying = 0;
  int round;
  float[][] terrain;
  
  retroField(){
    pg = createGraphics(1280, 800, P3D);
    cols = w / scl;
    rows = h/ scl;
    terrain = new float[cols][rows];
  }
  
  
  void display() {
  
    flying -= 0.1;
  
    float yoff = flying;
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
        xoff += 0.2;
      }
      yoff += 0.2;
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