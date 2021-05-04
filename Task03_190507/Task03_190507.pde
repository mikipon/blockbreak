
//ABOUT BLOCK

//block row and lines
int blocks_line = 10;//line
int blocks_row = 11;//row
//array for storing block position
int[] blockX = new int[blocks_row * blocks_line];
int[] blockY = new int[blocks_row * blocks_line];
color[] blockColor = new int[blocks_row * blocks_line];
//first block position
int first_block_x = 10;
int first_block_y = 10;
//block size
int block_width = 33;
int block_height = 20;
//Block spacing
int block_interval_x = 35;//Block spacing (x direction)
int block_interval_y = 20;//Block spacing (y direction)
//block color
color block_color = color(204,102,255);
DrawBlock[] block = new DrawBlock[blocks_row * blocks_line];


//ABOUT BALL

//zahyo of ball
float[] xpos = new float[4];
float[] ypos = new float[4];
int[] xdirection = {1, 1, -1, -1};
int[] ydirection = {1, -1, -1, 1};
//speed of ball

float[] speedX = new float[4];
float[] speedY = new float[4];

//ABOUT BAR

//parameter of bar
float bar_width = 60;
float bar_height = 15;
//position of bar
int barX = 200;
int barY = 470;
//color of bar
color barColor = color(255,255,102);

//ABOUT OTHER
color backColor = color(0);
boolean click = false;
int score = 0;

//Block drawing class
class DrawBlock{
  int x, y, w, h;
  color rgb;
  //override
  DrawBlock(int blockX, int blockY, int blockWidth, int blockHeight, color rgbColor){
    x = blockX;
    y = blockY;
    w = blockWidth;
    h = blockHeight;
    rgb = rgbColor;
  }
  
  void init(){
    fill(rgb);
    rect(x, y, w, h);
  }
}

void setup(){
  size(400, 500);
  //first position of ball
  randomSeed(millis());
  for(int i = 0; i < 4; i++){ 
    xpos[i] = random(12, width - 12); 
    ypos[i] = random(250, height - bar_height); 
    speedX[i] = random(random(-3, -3), random(3, 3));
    speedY[i] = -3.5;
  }
  //shokika of block
  for(int y = 0; y < blocks_line; y++){
    for(int x = 0; x < blocks_row; x++){
      int i = x + (y*blocks_row);
      blockColor[i] = block_color;
      blockX[i] = first_block_x + block_interval_x * x;
      blockY[i] = first_block_y + block_interval_y * y;
      block[i] = new DrawBlock(blockX[i], blockY[i], block_width, block_height, blockColor[i]);
    }
  }
}

void draw(){
  background(backColor);
  
  //Block initialization
   for(int i = 0; i < block.length; i++){
    block[i].init();
  }
  
  //draw bar
  fill(barColor);
  rect(barX, barY, bar_width, bar_height);
  barX = mouseX - (int)bar_width/2;
  
  //screan outside
  if(barX > width - bar_width){
    barX = width - (int)bar_width;
  }
  if(barX < 0){
    barX = 0;
  }
  
  //draw ball
  for(int i = 0; i < 4; i++){
    ellipse(xpos[i], ypos[i], 12, 12);

    //move ball
    if(click){
        xpos[i] += xdirection[i] * speedX[i];
        ypos[i] += ydirection[i] * speedY[i];
    }
    
    //shoutotsu kabe
    if( xpos[i] > width || xpos[i] < 0){
      speedX[i] *= -1;
    }
    if( ypos[i] < 0){
      speedY[i] *= -1;
    }
    
    //gameover
    if(ypos[0] > height && ypos[1] > height && ypos[2] > height && ypos[3] > height){
      text("Game Over", width/2 , height/2);
      text("Your Score : "+score, width/2 , height/2 + 30);
    }
  

    //shoutsu bar
   if(xpos[i] > barX-5 && xpos[i] < barX + bar_width + 5){
      if(ypos[i] > barY && ypos[i] < barY + 6){
        xdirection[i] += random(-3, 3);
        ydirection[i] *= -1.01;
      }
    }

  //syoutotsu block
   for(int y = 0; y < blocks_line; y++){
    for(int x = 0; x < blocks_row; x++){
      int j = x + (y * blocks_row);
      blockX[j] = first_block_x + block_interval_x * x;
      blockY[j] = first_block_y + block_interval_y * y;
    
      if(blockColor[j] == block_color){
        if(ypos[i] > blockY[j]-4 && ypos[i] < blockY[j] + block_height+4){
          if(xpos[i] > blockX[j]-4 && xpos[i] < blockX[j] + block_width+4){
            speedY[i] *= -1;
            blockColor[j] = backColor;
            score += 10;
          }
        }
        
        if(ypos[i] > blockY[j] && ypos[i] < blockY[j] + block_height){
          if(xpos[i] > blockX[j]-4 && xpos[i] < blockX[j]-5 ){
            speedX[i] *= -1;
            blockColor[j] = backColor;
          }
        
          if(xpos[i] > blockX[j]+4 + block_width && xpos[i] < blockX[j] + block_width + 5){
            speedX[i] *= -1;
            blockColor[j] = backColor;
          }
        }
      }
      block[j] = new DrawBlock(blockX[j], blockY[j], block_width, block_height, blockColor[j]);   
    }
  }
  text("Score : "+score, 300 ,400);
 }
}

void mousePressed(){
  click = !click;
}
