class Particle
{
	int finger_which;
	color clr;
	PVector pt;

	int lifespan = 150;

	Particle( int _finger_which, PVector _pt, color _clr)
	{
		finger_which = _finger_which;
		clr = _clr;
		pt = _pt; 
	}



	void run()
	{
		strokeWeight(finger_which+1);
		fill(clr);

		pushMatrix();
			
			translate( pt.x, pt.y, map(pt.z, 0, 100, 900, -900) );
			ellipse(0,0,20,20);

		popMatrix();


		if(lifespan > 0 ){
			lifespan--;
		}
	}

	boolean isDead()
	{
		return ( lifespan <= 0 );
	}
}