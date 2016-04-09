class Particle{
	int finger_which;
	color clr;
	PVector pt;

	int lifespan = (int)random(5,11);

	PVector location;
	PVector velocity;
	PVector acceleration;

	HOscillator oSize, oRotX, oRotY, oRotZ;

	Particle(int i, int _finger_which, PVector _pt, color _clr ) {
		finger_which = _finger_which;
		clr = _clr;
		pt = _pt;

		location = pt.get();
		velocity = new PVector( random(-2,2), random(-2,2) );
		acceleration = new PVector(0, 0.1);

		oSize = new HOscillator().range(0,40).speed(1).freq(5).currentStep(i);

		oRotX = new HOscillator().range(-360,360).speed(0.05).freq(5).currentStep(i);
		oRotY = new HOscillator().range(-360,360).speed(0.07).freq(5).currentStep(i);
		oRotZ = new HOscillator().range(-360,360).speed(0.03).freq(5).currentStep(i);
	}

	void run() {
		velocity.add(acceleration);
		location.add(velocity);

		oSize.nextRaw();
		oRotX.nextRaw();
		oRotY.nextRaw();
		oRotZ.nextRaw();

		noStroke(); fill(clr); lights();

		pushMatrix();
			// translate(location.x, location.y, map(pt.z,0,100,900,-900) );
			translate(location.x, location.y, random( -50, 50 ) );

			rotateX( radians( oRotX.curr() ) );
			rotateY( radians( oRotY.curr() ) );
			rotateZ( radians( oRotZ.curr() ) );

			// box( oSize.curr() );

			sphereDetail(  (int) ( lifespan+1/oSize.curr() ) );
			sphere( lifespan-oSize.curr() );

		popMatrix();

		if (lifespan>0) lifespan--;
	}

	boolean isDead() {
		return (lifespan==0);
	}
}