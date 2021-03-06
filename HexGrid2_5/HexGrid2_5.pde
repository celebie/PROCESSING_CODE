//
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
//
Boolean isFinal = true;
int alf = 11;

int cX;
int cY;

int shapeSize = 20;
int gridWidth = 800+shapeSize;
int gridHeight;

// circles
int cirXX;
int cirYY;
int startX = 0;
int startY = 0;
float angle      = 45; 
float radius     = 100;
float frequency  = 1;
int circleSize   = 100;

////////////////////////////////////////////////////
//
void setup() {

  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(1);

  //  setup variables
  cX = width/2;
  cY = height/2;

  startX = cX;
  startY = cY;

  gridHeight = height+shapeSize;
  gridWidth = width + shapeSize;
  
  strokeWeight(2);
}

float xx = -shapeSize;
float yy = -shapeSize;
boolean gotGrid = false;

////////////////////////////////////////////////////
//
void draw()
{
  
  while( ! gotGrid )
  {
    for( int cc = 0; cc <= width*8; cc ++ )
    {
      noFill();
      smooth();

      cirXX = startX - int( cos(radians(angle)) * radius );
      cirYY = startY - int( sin(radians(angle)) * radius );
      
      stroke( #1975EF, alf*2 );
      strokeWeight( 1 );  
      hexagon( xx, yy, shapeSize );
      

      //  points 
      strokeWeight( random(shapeSize) );  

//      stroke( #97EF51, alf );
//      point( random(cirXX), random(cirYY) );//, shapeSize );

      stroke( #1975EF, alf );  // EF5150
      point( random(xx), random(yy) );//, shapeSize );


      
      // sun ball
      if( cc % 3 == 0 ) {
        stroke( #EFEF00, alf*3 );  // 75EF19
      } else { 
        stroke( #EF0000, alf );
      }
      
      strokeWeight(.3);

      line( xx, yy, cirXX, cirYY );
      
      
      
      if( xx >= width )
      {
          xx = -shapeSize;
          yy += shapeSize;
          
        
      } else {
        xx += shapeSize*.5;
      }
      
      if ( angle < 360 )
        angle += alf;
      else if ( angle < 720 )
        angle++;
      else
        angle += 1.5;
/*
  if ( angle >= maxAngle )
  {    
    exit();
  }
  */    
      
    }
    gotGrid = true;
  }
  

  exit();  

}

//////////////////////////////////////////////////////////////////////////
//  HEXAGON inspired by http://www.rdwarf.com/lerickson/hex/index.html
void hexagon( float startX, float startY, float shapeSize ) {

  line( startX, startY+(shapeSize*.5), startX+(shapeSize*.25), startY );
  line( startX+(shapeSize*.25), startY, startX+(shapeSize*.75), startY );
  line( startX+(shapeSize*.75), startY, startX+(shapeSize), startY+(shapeSize*.5) );

  line( startX+(shapeSize), startY+(shapeSize*.5), startX+(shapeSize*.75), startY+shapeSize );
  line( startX+(shapeSize*.75), startY+shapeSize, startX+(shapeSize*.25), startY+shapeSize );
  line( startX+(shapeSize*.25), startY+shapeSize, startX, startY+(shapeSize*.5) );
}




///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
void doExit() 
{   
  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }

  super.stop();
}

///////////////////////////////////////////////////////////
//  Helper to random(255) stroke
void randFill() {  
  fill( random(255), random(255), random(255), alf );
}
void randStroke() {  
  stroke( random(255), random(255), random(255), alf );
}
void randStroke100() {  
  stroke( random(255), random(255), random(255), 100 );
}





///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  PFont font = createFont( "Silom", 15 );
  //PFont font = loadFont( "Silom-20.vlw" );
  
  smooth();
  textFont( font );
  strokeWeight(1);

  fill( #00EFEF , 666 );
  text( " "+dailyMsg, this.width-185, this.height-5);
}
