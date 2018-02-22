import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import fixlib.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class CircleGriddish extends PApplet {


// https://github.com/ericfickes/FIXLIB 


Fixlib fix = Fixlib.init(this);
//
//  go smaller

Boolean isFinal = true;
int alf = 42;


int shapeSize = 10000;
float minShapeSize = 10;
//float maxShapeSize = 100;

int cX;
int cY;


int[] palette = { 
  0xff197500,
0xffD89054,0xff4A1A08,0xffF9DA9B,0xff955029,0xffE4B58B,0xffB59F88,0xffF5D7C9,0xffDCD3BC,0xffDCEED2,0xffC3C6AA,0xff877D60,0xffDDEEEE,0xffAA7C64,0xffD9BBBC,0xffF6DDEE,0xffC9CDCC,0xff879285,0xffDDDDDD,0xffB9B9BC,0xff77665E,0xffFFFFDD,0xffFFFFC1,0xffFFEEC4,0xffFFEEDD,0xffEEEEDD,0xffEEEEC6 };

int x = 0;
int y = 0;

int ct = 0;
float maxCt = 0;

////////////////////////////////////////////////////
//
public void setup() {
  // setup core sketch settings items
  
  frameRate(303);
  background(alf);
  fix.alpha(alf);
  noFill();
  strokeWeight(.5f);
  

}


////////////////////////////////////////////////////
//

public void draw()
{
  //  get small

  while( shapeSize >= minShapeSize ) 
  {
    //  re-init loop vars
    x = y = ct = (int)-alf;

    maxCt = fix.getMax( shapeSize );
    strokeWeight( shapeSize*.01f );

    fix.ranPalStroke(palette);
      
    while( ct < maxCt ) {

      smooth();
    
      fix.circle( x, y, shapeSize, shapeSize );

      fix.hexagon( x, y, shapeSize );

      rect( x, y, shapeSize, shapeSize );

      ellipse( x, y, shapeSize, shapeSize );

      

      if( x >= width ) {
        x = (int)-alf;
        y += shapeSize; 
      } else {
        x += shapeSize;
      }
      
      ct++;
    }
    

    // shrink the shape
    shapeSize = PApplet.parseInt(shapeSize/2);
  }

stroke( 0, pow(alf,2) );
drawFrame();

  doExit();
}


///////
//  draw frame
public void drawFrame() {

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


///////////////////////////////////////////////////////////
//  
//  End handler, saves png to ../OUTPUT
public void doExit() 
{

  artDaily("ERICFICKES.COM");

  //  if final, save output to png
  if ( isFinal )
  {
    save( fix.pdeName() + fix.getTimestamp() + ".png" );
  }
  
  noLoop();
  exit();
}

///////////////////////////////////////////////////////////
//
//  Spit out ART DAILY message
public void artDaily( String dailyMsg ) {

  textFont( createFont( "Silom", 18 ) );
  smooth();

  //  stroke(#EFEFEF);
//  fill(#EE0000);
  //fill(#00EE00);
  fill(0xffEFEFEF);
  text( " "+dailyMsg, this.width*.45f, this.height-18);
}

  public void settings() {  size(1024, 768);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CircleGriddish" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
