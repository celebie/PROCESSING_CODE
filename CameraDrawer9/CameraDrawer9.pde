import processing.video.*;
// https://github.com/ericfickes/FIXLIB 
import fixlib.*;

Fixlib fix = Fixlib.init(this);


Capture cam;

PVector a, b, c, d;
int sz = 39,
    ms = 100,
    strokeWt = 1,
    horSlitSz; 

float xx, yy, eSz;
PImage snap;



//////////////////////////////////////////////////////////////////////
void setup() 
{
  size(1280, 720, P3D);
  background(255);
  smooth();
  strokeWeight(strokeWt);
  cam = new Capture(this, Capture.list()[0]);
  cam.start();     
  xx = yy = 0;
}

//////////////////////////////////////////////////////////////////////
void draw() {
  if (cam.available()) 
  {

    if(snap==null || millis() % ms==0 )
    {
      
      fill(255);
      textSize(random(sz));
      text("snap"+frameCount, xx, yy);
      cam.read();
      snap = cam;

      tint(255,100);
      image(snap, width-200, yy, 200, 200);

      snap.mask(cam);
      snap.filter(POSTERIZE,4);
      snap.filter(INVERT);
      image(snap, width-200,yy+200,200,200);
    }
    

//  ROTATO!
  if(frameCount%sz==0)
  rotateX(frameCount%width);
  else if(frameCount%55==0)
  rotateY(frameCount%width);
  else if(frameCount%89==0)
  rotateZ(frameCount%width);
  else if(frameCount%154==0)
  rotate(frameCount%width);


    // "slit cam" - real time
    if(frameCount%7==0)
    {
	  // "FIRE"ish neon - stroke(xx,yy,sz);
	  // stroke(xx,yy,sz);

    	//	VERTICAL
    	cam.read();
    	// tint(xx,yy,sz);// random(sz,255));
    	tint( snap.get( (int)xx, (int)yy) );
    	image(cam.get((int)xx, 0, (int)random(HALF_PI), (int)yy), xx, 0 );

    }
    else if ( frameCount%11==0)
    {

      //	HORIZONTAL ( right to left now that XX has new noise)
      horSlitSz = (int)random(HALF_PI,13);
      
      //stroke(xx,yy,sz);
      stroke( snap.get( (int)xx, (int)yy) );
      // noStroke();
      rect(xx, yy-1, (width-xx), horSlitSz+1, random(-TWO_PI, -sz) );
      //noTint();

      cam.read();
      
		if(yy>=(height*.45))
		{
			cam.filter(POSTERIZE, random(2,sz/2)+noise(frameCount) );

		}
		else if(yy<=(height/9))
		{
			cam.filter(GRAY);
		}


     image( cam.get( (int)xx, (int)yy, (int)(width-xx), horSlitSz), xx, yy);//, (width-xx), horSlitSz );

    }
 	

  if( frameCount % ms == 0 || frameCount%sz==0){

    tint(xx,yy,sz);
    eSz = random(width-200);  // (width-xx)*noise(frameCount);
    yy = yy*noise(frameCount);

    image(snap, eSz, yy, 200, 200);

    stroke( snap.get( (int)xx, (int)yy), random(255));
    strokeWeight(1);
    line(eSz+200, 0, eSz+200, height);

    noFill();
    strokeWeight(PI);
    // stroke(yy, xx, sz);
    stroke( snap.get( (int)xx, (int)yy) );
    rect(eSz, yy, 200, 200, random(sz));
}

    xx = (frameCount%width)*noise(frameCount);
    yy = (frameCount%height) - int( sin(radians(frameCount)) * sz ) % height;

// xx +=noise(frameCount)*10;


    // a = new PVector( xx-sz, yy, frameCount%height );
    // b = new PVector( xx, yy-sz, frameCount%height );
    // c = new PVector( xx+sz, yy, frameCount%height );
    // d = new PVector( xx, yy+sz, frameCount%height );

    a = GetRandVector( xx, yy, sz );
    b = GetRandVector( xx, yy, sz );
    c = GetRandVector( xx, yy, sz );
    d = GetRandVector( xx, yy, sz );



//  RE-UP SNAP
    if(frameCount%sz==0 || frameCount%ms==0){
      cam.read();
      snap = cam;
    }

  // "FIRE"ish neon - stroke(xx,yy,sz);
	stroke( snap.get( (int)xx, (int)yy) );
  strokeWeight(strokeWt);

  // noTint();
  beginShape();


  	texture( snap.get( (int)xx, (int)yy, sz, sz ) );

    vertex(a.x, a.y, 0,0 );
    vertex(b.x, b.y, sz, 0 );
    vertex(c.x, c.y, 0, sz );
    vertex(d.x, d.y, sz, sz );
    
  endShape();

  stroke( snap.get( (int)xx, (int)yy) );
  fill( snap.get( (int)yy, (int)xx) );
  
  eSz = (frameCount%sz/2)*noise(frameCount);

  stroke(xx,yy,sz);
  rect( yy, xx, random(sz), random(sz), random(-TWO_PI,TWO_PI) );
  rect( xx+sz, yy-sz, random(sz), random(sz), random(-TWO_PI,TWO_PI) );


  strokeWeight(PI);
	stroke(xx,yy, sz+eSz );
	ellipse(xx,yy,eSz,eSz);


  strokeWeight(TWO_PI);	
	stroke( snap.get( (int)yy, (int)xx) );
	point(xx,yy);


  strokeWeight(PI);
	stroke( snap.get( (int)xx, (int)yy) );
	point(xx,yy);


	strokeWeight(strokeWt);

  
  }


 // STOPPER
 if(frameCount>width*height)
 {
  save(fix.pdeName()+fix.getTimestamp()+".png");
  cam.stop();
    save( fix.pdeName() + fix.getTimestamp() + ".png");
    noLoop();
    exit();
  }

  
}


//  Return a random vector based on supplied x,y and sz
PVector GetRandVector( float x, float y, float sz )
{
  return new PVector( 
        x - int( cos(radians( random(360) )) * sz ),
        y - int( sin(radians( random(360) )) * sz ),
        random(-sz,sz)
      );
}





////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){
  case 's':
    save( fix.pdeName() + fix.getTimestamp() + ".png");
  break;

  case ESC:

    save( fix.pdeName() + fix.getTimestamp() + ".png");
    noLoop();
    exit();
  break;
}

}