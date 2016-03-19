String lines[];
String txt;
float xx,yy, tLen;

void setup()
{
  size( displayWidth, displayHeight );
  background(#EF2014);

//	ORANGE - EF6900

  lines = loadStrings("my.pdf");
}


void draw()
{
// fill( random(20,40), random(200,215), random(11), 5);
// rect(0,0, displayWidth, displayHeight);

	if(frameCount < lines.length )
	{
		txt = lines[frameCount];
		tLen = txt.length();

	  // stroke( random(20,40), random(200,215), random(11) );
	  // line( random(yy), yy, random(yy), yy);


	  fill( tLen, tLen, tLen );
	  textSize(random(tLen));

	  text( txt, random( width ), yy );

	  if(yy<height)
	  {
	  	yy += txt.length();
	  } 
	  else
	  {
	  	yy = random(PI);
	  }


	} 
	else 
	{
		tLen = 14;
		textSize(tLen);

		fill(#EF1975);
		text("ERICFICKES.COM", 0, height-(tLen*2) );

		fill(#19EF75);
		text("ERICFICKES.COM", 0, height-(tLen*1) );

		fill(#1975EF);
		text("ERICFICKES.COM", 0, height );

		noLoop();
	}


}



////// S SAVE HANDLER /////////

void keyPressed(){
switch(key)
{
  case 's':
    save(pdeName() + getTimestamp() + ".png");
  break;

  case ESC:
    save(pdeName() + getTimestamp() + ".png");
    exit();
  break;
}


} 




public String getTimestamp() {
  return ""+month()+day()+year()+hour()+minute()+millis();
}


/////////////
//  TODO: Is there a better way to get the current sketch name?
public String pdeName() {
  return split( this.toString(), "[")[0];
}


