//  grid with shrinking strokeWeight
import processing.pdf.*;

int sColor = 0;
float x, y;
int sz = 1000;


float xx, yy, theta, r, i, cX, cY;

///////////////////////////////////////////////////////////////////////////////
void setup()
{
  size(1280, 960);//, P3D );
  // size(2560, 1920, P3D );
  frameRate(420);
  
  smooth();

  strokeCap(ROUND);

  rectMode(CENTER);
  ellipseMode(CENTER);

  noFill();

  
  x = y = -sz;
  cX = width/2;
  cY = height/2;

  beginRecord(PDF, fileStamp()+".pdf");
}


///////////////////////////////////////////////////////////////////////////////
void draw()
{  
  smooth();

    sColor = ( sColor == 0 ? 255 : 0 );
    stroke(sColor, random(155,255));


theta = sqrt(frameCount%width) * 2 * PI;
r = sqrt(frameCount%width);
xx = cX -cos(sqrt(frameCount%width)*2*PI)*sqrt(frameCount%width);
yy = cY - sin(sqrt(frameCount%width)*2*PI)*sqrt(frameCount%width);

ellipse( xx, yy, sz, sz );


if(frameCount%r==0)
{
	strokeWeight(HALF_PI);
	// stroke(sColor);//, random(122,222));
	rect( (cX+x)%width, y, r/theta, r/theta, -(theta/PI) );

  strokeWeight(sqrt(sz));

	if(r%6==0)
	{
		// stroke( r, y, x, random(150,250));
		// stroke( r, theta, xx, random(150,250));
		// strokeWeight(HALF_PI);
    stroke(random(255));
		line(xx, yy, x, y);
		line(y,x,yy,xx);
	}
}
	

  //  increment size
  if(x<width){
    x+=sz;
  } else {
    x = -sz;
    y += sz;
  }

  if( y > height ){

    y = -sz;
    sz -= sqrt(sz);

	strokeWeight(sqrt(sz));

    cX = random(width/2);
    cY = random(height/2);
  }
  

  
  if( sz < 40 ){

    endRecord();

    stop();
  }

}



//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}



