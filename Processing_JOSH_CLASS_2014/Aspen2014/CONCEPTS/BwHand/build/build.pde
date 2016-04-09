import de.voidplus.leapmotion.*;
LeapMotion leap;
PImage iTip, iDip, iPip, iMcp;

void setup() {
  size(900,900, P3D);
  background(255);
  smooth();

  leap = new LeapMotion(this);

	iTip = loadImage("cross.png");
	// iDip = loadImage("dip.png");
	// iPip = loadImage("pip.png");
	// iMcp = loadImage("mcp.png");

}


PVector hand_position, finger_tip, finger_dip, finger_pip, finger_mcp;
float curZ;


void draw() {

fill(255,3);
noStroke();
rect(0,0, width, random(height));

	// HAND TIME
	for(Hand hand : leap.getHands() )
	{

		
		hand_position = hand.getPosition();
		curZ = map( hand_position.z, -25, 100, 500, -500 );
		stroke(curZ);		
		// PALM
		fill(#19ef75);
		pushMatrix();
			translate( hand_position.x, hand_position.y, curZ );
		  
			rotateX( radians( map( hand.getRoll(), -100, 100, 180, -180 ) ) );
			rotate( radians( map( hand.getPitch(), -100, 100, 180, -180 ) ) );

			sphereDetail((int)map( hand.getRoll(), -50, 50, 111, -111 ));
			
			sphere(20);

		popMatrix();


		// FINGER TIME
		for( Finger finger : hand.getFingers() ){

			finger_tip = finger.getPositionOfJointTip();
			// finger_dip = finger.getPositionOfJointDip();
			// finger_pip = finger.getPositionOfJointPip();
			// finger_mcp = finger.getPositionOfJointMcp();

			

			pushMatrix();

				translate( finger_tip.x, finger_tip.y, finger_tip.z );
				

				// sphereDetail((int)-finger_tip.z);
				// sphere(20);
				// text("TIP", 0, 0);


				image(iTip, 0,0);

			popMatrix();


		}


	}



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

