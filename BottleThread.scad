include <threaded-library/Thread_Library.scad>

//$fn=32;
//$fs=0.75;$fa=5;

// Lid

LidHeight=8;
WallThickness=2;

// Thread parameters

TotalHeight = 14;
ThreadOuterDiameter=27.65;
ThreadInnerDiameter=25.5; // Used only for cleanup.
ThreadPitch=2.7;
ToothHeight=1.2;
ProfileRatio=0.4;
ThreadAngle=20;
Clearance=0.1;
Backlash=0.15;

/* outer_thread(); */
/* inner_thread(); */

/* nthread(); */

module inner_thread(l=LidHeight,w=WallThickness,d=ThreadOuterDiameter){
    difference(){
        intersection(){
            cylinder(r=d/2+w, h=l);
            translate([0,0,-ThreadPitch])
              thread(l=l*2,d=d);
        }
        translate([0,0,-1])
            cylinder(r=d/2-w,h=l+w+2);
	}
}

module outer_thread(l=LidHeight,w=WallThickness,d=ThreadOuterDiameter){
    difference(){
		    cylinder(r=d/2+w,h=l);
        translate([0,0,-ThreadPitch])
          nthread(l=l*2,d=d);
        cylinder(r=d/2-w, h=l+1);
	}
}

module nthread(l=TotalHeight,d=ThreadOuterDiameter){
	// Most important thing -- thread

	/* translate([0,0,ThreadPitch]) */
		//trapezoidThread
		trapezoidThreadNegativeSpace
		(
			length=l,
			pitch=ThreadPitch,
			pitchRadius=d/2+Clearance,
			threadHeightToPitch=ToothHeight/ThreadPitch,
			profileRatio=ProfileRatio,
			threadAngle=ThreadAngle,
			clearance=Clearance,
			backlash=Backlash
		);
}

module thread(l=TotalHeight,d=ThreadOuterDiameter){
	// Most important thing -- thread

	translate([0,0,-ThreadPitch])
		//trapezoidThread
		trapezoidThread
		(
			length=l,
			pitch=ThreadPitch,
			pitchRadius=d/2-Clearance,
			threadHeightToPitch=ToothHeight/ThreadPitch,
			profileRatio=ProfileRatio,
			threadAngle=ThreadAngle,
			clearance=Clearance,
			backlash=Backlash
		);
}
