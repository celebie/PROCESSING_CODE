//
//  Learning Processing CH3 : Interactivity
//

Boolean isFinal = true;
float alf = 11;
float shapeSize = alf;

int cX;
int cY;

color[] palette = { 
  #A59DA1, #D96D55, #F36613, #A9ABEA, #D23301, #F6FAFD, #AB6E9C, #D6F9FF, #F8751E, #768A00, #F05510, #FFEE51, #FFB02A, #D7D5FA
};


int ct = 0;
int maxCt = 0;

////////////////////////////////////////////////////
//
void setup() {
  // setup core sketch settings items
  size(1024, 768);
  frameRate(303);
  background(9);

  //  setup variables
  cX = width/2;
  cY = height/2;

  noFill();
  ellipseMode(CENTER);  
  maxCt = 1000;


  // RED  - stroke( #B00B13, alf*3 );
  // GREEN - stroke( #20EF12, alf*3 );  
//  stroke( #B00B13, alf*3 );
//  drawFrame();
}


////////////////////////////////////////////////////
//

float _x = 135;
float _y = 135;
PVector thisPt, lastPt, pv1, pv2, pv3, pv4 = new PVector();

void draw()
{
  _x = lerp( 200, random(width*2), .75 );
  _y = lerp( 404, random(height), .75 );

  strokeWeight( random(1.5) );  // 3.3
  smooth();
  noFill();

  //  zoogMouse();
  if ( pmouseX != 0 ) {

    strokeWeight( abs( pmouseX-mouseX ) );  // 3.3
    stroke(0, alf*10);

    line( mouseX, mouseY, pmouseX, pmouseY );


    randStrokeUser();
    hexagon( mouseX-alf, mouseY-alf, shapeSize+alf );

    randStrokeUser();
    hexagon( pmouseX+alf, pmouseY+alf, shapeSize+alf );

    strokeWeight( random(1.5) );  // 3.3
  }

  //  CH2 shapes
  stroke(#EF1919, alf );
  arc( _x, _y, cX*alf, cY*alf, TWO_PI, PI);

  randStrokeUser();
  curve( _y, _x, random(cX), random(cY), cX+alf+_x, cY+alf+_y, cX*.5, cY);

  randStroke();
  quad( _x, _y, cX*alf, cY*alf, _x+shapeSize, _y+shapeSize, cX*1.5, cY );

  randStrokeUser();
  triangle( _y, _x, _x, _y, random(cX), random(cY) );

  //  end CH2


  if ( ct >= maxCt ) {

    //  scan lines
    stroke(#000000, alf );
    for ( int ll = 0; ll <= width; ll += 2 ) 
    {  
      strokeWeight( random(alf) );  
      line( 0, ll, width, ll );

      strokeWeight( random(alf*.5) );
      line( ll, 0, ll, height );
    }

    exit();
  }

  ct++;
}


void mousePressed() {
  
  randStroke100();
  
  hexagon( mouseX, mouseY, alf*5 );
  
}


void keyPressed() {
  randStrokeUser();
  drawFrame();
}













void zoog() {

  ellipseMode(CENTER);
  rectMode(CENTER);
  stroke(0);
  fill(150);
  rect(100, 100, 20, 100 );
  fill(255);
  ellipse(100, 70, 60, 60);
  fill(0);
  ellipse(81, 70, 16, 32 );
  ellipse(119, 70, 16, 32);
  stroke(0);
  line(90, 150, 80, 160);
  line(110, 150, 120, 160);
}



///////
//  draw frame
void drawFrame() {

  rectMode(CORNER);

  strokeWeight( 100 );
  rect( 0, 0, width, height);

  strokeWeight( 5 );
  rect( 64, 65, width-128, height-129 );

  strokeWeight( 15 );
  rect( 84, 85, width-168, height-168 );

  //  dashed line
  strokeWeight(6);
  int x = 110;
  int y = 110;

  strokeCap(PROJECT);

  for ( int pp = 0; pp <= (width*height); pp++ ) { 

    if ( x <= (width-110) ) {
      // top row    
      point( x, y );
      //  bottom row
      point( x, 790 );

      x += 10;
    } 
    else if ( y <= 780 ) {

      // left row    
      point( (width-110), y );
      //  right row
      point( 110, y );
      y += 10;
    }
  }

  strokeWeight( 5 );
  rect( 122, 122, width-245, height-245 );
}

//////////////////////////////////////////////////////////////////////////
//  Draw manual circle
//  ellipse(x, y, width, height)

float radius = 18, xx, yy;

void circle( float startX, float startY, float w, float h ) {

  float angle = 0;

  while ( angle < 360 ) {
    xx = startX - int( cos(radians(angle)) * radius );
    yy = startY - int( sin(radians(angle)) * radius );


    ellipse( xx, yy, w, h );

    angle++;
  }
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
void exit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( this + "-" + month()+day()+year()+hour()+minute()+second()+millis()+".png" );
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

////////////////////////////////////////////////////
//  Randomly stroke using image from color list
void randStrokeUser()
{
  // pallete
  stroke( palette[ int(random( palette.length-1 )) ], alf*.75 );
}
void randFillUser()
{
  fill( palette[ int(random( palette.length-1 )) ], alf*.75 );
}




///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  //  stroke(#EFEFEF);
  fill(255);
  text( " "+dailyMsg, this.width*.45, this.height-18);
}

