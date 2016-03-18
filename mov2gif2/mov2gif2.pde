//	MOV to GIFFER
//	1. locate movie on vimeo
//  2. go to http://www.convertfiles.com/
//	3. conver to MOV
//	4. update size() to match MOV dimensions
//	5. run through this pde
//	6. let's party
/*
- https://vimeo.com/23097220
https://www.youtube.com/watch?v=oyi_q7hIOmw
https://vimeo.com/75799644
https://vimeo.com/72088585
https://vimeo.com/127970339
https://vimeo.com/127877243
https://vimeo.com/127869970
https://vimeo.com/127315710
https://vimeo.com/127315709
https://vimeo.com/127306632
https://vimeo.com/126424925d
https://vimeo.com/126321193
 */
import processing.video.*;
import ddf.minim.*;

Minim minim;
AudioInput in;
Movie myMovie;
int MODE = 2;	// 2
float cX, cY;
/*
1 = vertical
2 = horizontal
*/
String MOV_FILE = "66881522.mov";	//	960, 720


void setup() 
{
size(960, 720, P3D);
// size(960, 720, P3D);
// size(640, 360);
// size(1280,720,P3D);

  minim = new Minim(this);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();

  myMovie = new Movie(this, MOV_FILE );
  myMovie.loop();
  cX = width/2;
  cY = height/2;

}

void draw() {

// alpha((int)random(255));

myMovie.filter(DILATE);
myMovie.filter(POSTERIZE,11);
tint(255,20);

	switch(MODE)
	{
		case 1:	//"vert":
			image(myMovie, 0, frameCount);

			if(frameCount>=height){
				bail();
			}
		break;

		case 2:	//"horizontal":
			image(myMovie, frameCount,0);

			if(frameCount>=width){
				bail();
			}
		break;
	}

//strokeWeight(HALF_PI);
// fill(frameCount%255);
tint(255);
beginShape(TRIANGLES);
noStroke();
noFill();
smooth();
  	beginShape(POLYGON);
texture(myMovie);
  // draw the waveforms so we can see what we are monitoring
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {

    // line( i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50 );
    vertex( i, (frameCount+ in.left.get(i)*50)%height , frameCount%height, random(i), random(i));
    vertex( i+1, (frameCount+ in.left.get(i+1)*50)%height , frameCount%height, random(i), random(i));
    // line( i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50 , random(i), random(imgTexture.height));
	vertex( i, (frameCount-  in.right.get(i)*50)%height , frameCount%height, random(i), random(i));
	vertex( i+1, (frameCount- in.right.get(i+1)*50)%height , frameCount%height, random(i), random(i));

  }
endShape();

}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}


void bail(){
	save(MOV_FILE+"_"+timeStamp()+".png");
	myMovie.stop();
	stop();
	exit();
}


/////////////////////////////////////////////////////////////////////////////
// PVector circleXY( float centerX, float centerY, float radius, float angle )
// {
//   return new PVector(
//                 centerX - int( cos(radians(angle)) * radius ),
//                 centerY - int( sin(radians(angle)) * radius )
//                 );
// }

//  return unique filename_timestamp string
public String sketchName(){
  return split( this.toString(), "[")[0];
}
//  return unique filename_timestamp string
public String fileStamp(){
  return split( this.toString(), "[")[0] + "_" +month()+day()+year()+hour()+minute()+millis();
}
//  return unique filename_timestamp string
public String timeStamp(){
  return " "+month()+day()+year()+hour()+minute()+second();
}
