//  
//  http://ericfickes.com
//  http://www.openprocessing.org/sketch/78639
import fixlib.*;

//  https://github.com/ericfickes/FIXLIB
Fixlib fix = Fixlib.init(this);

Boolean isFinal = true;
int alf = 100;

ArrayList p3;
PImage img;

float a, x, y, co, bri, i, sz;
int cX, cY;

float angle = 0,angle2 = 0;
float x2, y2;

////////////////////////////////////////////////////////////////////////
void setup() {
size(1024,768);  //  big:  1024x768

  background(alf);
  fix.alpha(alf);

  cX = width/2;
  cY = height/2;

  img = loadImage("indies-cyansilver.jpg");
  p3 = fix.getImgColors(img);

  fill(18);
//  strokeWeight();
  for( int h = 0; h < height; h++ ) {
    stroke( random(37), random(37), random(37), alf);
    line( 0, h, width, h );
  }
  
  sz = 11;
  

}
 
/////////////////////////////////////////////////////////////////////////
void draw() {
  smooth();
  noFill();
  strokeWeight(noise(frameCount)+.75);
  
  x = cX - int( cos(radians(angle)) * sz );
  y = cY - int( sin(radians(angle)) * sz );
  
  

fix.ranPalStroke100(p3);
fix.trunk(x,y);


 


if( frameCount > 37 )  {
    stroke(random(75), random(75), random(75),alf);
     fix.trunk(x+37,y+37); 
   
    bezier( x+37,y+37, float(frameCount), sz*noise(angle), sz*noise(angle), float(frameCount), random(x+37), random(y+37) );
}

if( frameCount > 2012 )  {
    stroke(#EF2012, alf);
   fix.trunk(x-2012,y-2012); 
    bezier( x-random(20.12), y-random(20.12), float(frameCount), sz*noise(angle-random(20.12)), sz-random(20.12)*noise(angle), float(frameCount), random(x-random(20.12)), random(y-random(20.12)) );
}

if( frameCount > cX )  {
    stroke(random(75), random(75), random(75),alf);
  fix.trunk(x-cX,y-cY); 
    bezier( x, y, float(frameCount), sz*noise(angle), sz*noise(angle), float(frameCount), random(x), random(y) );
}




    fix.trunk( x+cX, y+cY ); 

    strokeWeight(2);
    fix.ranPalStroke100(p3);
    bezier( x, y, float(frameCount), sz*noise(angle), sz*noise(angle), float(frameCount), random(x), random(y) );

    stroke(random(255), random(255), random(37) );
    bezier( random(frameCount), height-angle, 
            random(angle), height-random(frameCount),
            random(frameCount), height-random(angle),
            angle, height-random(frameCount) );
             
    stroke(random(255), random(37), random(37) );
    bezier( random(frameCount), angle, 
            random(angle), random(frameCount),
            random(frameCount), random(angle),
            angle, random(frameCount) );
             
    angle *= noise(angle);



  if( frameCount > width) {
    doExit();
  }
}




///////////////////////////////////////////////////////////
//  End handler, saves png
void doExit() 
{

  artDaily("ERICFICKES.COM" );

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + "-" + fix.getTimestamp()+".png" );
  }

  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 37 ) );
  smooth();

  stroke(37,37,37 );
  text( " "+dailyMsg, width*.666, height-7);

  stroke(75,75,75 );
  text( " "+dailyMsg, width*.666, height-9);
}

