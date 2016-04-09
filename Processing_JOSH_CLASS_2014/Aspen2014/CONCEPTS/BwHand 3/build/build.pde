import de.voidplus.leapmotion.*;
LeapMotion leap;
PImage iTip, iDip, iPip, iMcp;

void setup() {
  size(900,900, P3D);
  background(255);
  smooth();

  leap = new LeapMotion(this);

	iTip = loadImage("cross.png");
	iDip = loadImage("dip.png");
	// iPip = loadImage("pip.png");
	// iMcp = loadImage("mcp.png");

}


PVector hand_position, finger_tip, finger_dip, finger_pip, finger_mcp;
float curZ;

ArrayList<PVector> tips = new ArrayList<PVector>();


void draw() 
{

	// HAND TIME
	for(Hand hand : leap.getHands() )
	{

		
		hand_position = hand.getPosition();
		curZ = map( hand_position.z, -25, 25, -5, 5 );
				
		/*
		// PALM
		strokeWeight(1);
		stroke( random(30,40), random(130, 140), random(30,40) );
		fill(random(200,242), random(200,242), random(11,111), random(100));

		pushMatrix();
			translate( hand_position.x, hand_position.y, hand_position.z );
		  
			rotateX( radians( map( hand.getRoll(), -100, 100, 180, -180 ) ) );
			rotate( radians( map( hand.getPitch(), -100, 100, 180, -180 ) ) );

			
			sphereDetail(9);
			sphere((int)map( hand.getRoll(), -50, 50, 111, -111 ));

		popMatrix();
		*/

		tips.add(hand_position);

		// FINGER TIME
		for( Finger finger : hand.getFingers() )
		{
			// store finger tip
			tips.add(finger.getPositionOfJointTip());
		}
	}



			beginShape(QUADS);
				texture(iPip);

				for( PVector pv : tips )
				{
					vertex( pv.x, pv.y, pv.z );
				}

			endShape();

		tips.clear();


}





////// S SAVE HANDLER /////////

void keyPressed(){
switch(key){
	case 's':
		save(pdeName() + getTimestamp() + ".png");
	break;

	case ESC:
		save(pdeName() + getTimestamp() + ".png");
		stop();
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

