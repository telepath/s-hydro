include <Screw_Library/Thread_Library.scad>

$fn=32;
$fs=0.75;$fa=5;

// Lid

LidHeight=9;
WallThickness=2;

// Nozzle

NozzleInnerDiameter=4;
NozzleOuterDiameter1=7;
NozzleOuterDiameter2=5;
NozzleHeight=7;

// Thread parameters

TotalHeight = 8;
ThreadOuterDiameter=27.7; 
ThreadInnerDiameter=25.5; // Used only for cleanup.
ThreadPitch=2.7;
ToothHeight=1.35;
ProfileRatio=0.4;
ThreadAngle=20;

// Slope

SlopeHeight=ThreadOuterDiameter/2;

// Hook
HookInnerDiameter=5;

cone_cap();
cleanhooks();


module cone_cap(){
	//Cap
	difference(){
		cylinder(r=ThreadOuterDiameter/2+WallThickness,h=LidHeight);
	translate([0,0,-ThreadPitch]) thread();
	cylinder(r=ThreadOuterDiameter/2, h=LidHeight+1);
	}

	//slope
	translate([0,0,LidHeight]) difference(){
		cylinder(r1=ThreadOuterDiameter/2+WallThickness,r2=NozzleOuterDiameter1/2,h=SlopeHeight);
		cylinder(r1=ThreadOuterDiameter/2,r2=NozzleInnerDiameter/2,h=SlopeHeight);
	}

	//Nozzle
	translate([0,0,LidHeight+SlopeHeight]) difference(){
		cylinder(r1=NozzleOuterDiameter1/2,r2=NozzleOuterDiameter2/2,h=NozzleHeight);
		cylinder(r=NozzleInnerDiameter/2,h=NozzleHeight);
	}
}

module thread(){

	// Most important thing -- thread

	translate([0,0,ThreadPitch])
		//trapezoidThread
		trapezoidThreadNegativeSpace
		(
			length=TotalHeight,
			pitch=ThreadPitch,
			pitchRadius=ThreadOuterDiameter/2,
			threadHeightToPitch=ToothHeight/ThreadPitch,
			profileRatio=ProfileRatio,
			threadAngle=ThreadAngle, 
			clearance=0.1,
			backlash=0.1
		);
}

module cleanhooks(){
	intersection(){
		difference(){
			hooks();
			cylinder(r=ThreadOuterDiameter/2,h=LidHeight+SlopeHeight);
		}
		cylinder(r=ThreadOuterDiameter/2+WallThickness,h=LidHeight+SlopeHeight);
	}
}

module hooks(){
	translate([0,0,LidHeight]){
		translate([0,-ThreadOuterDiameter/2-WallThickness,0]) hook();	
		rotate(120) translate([0,-ThreadOuterDiameter/2-WallThickness,0]) hook();	
		rotate(240) translate([0,-ThreadOuterDiameter/2-WallThickness,0]) hook();	
	}
}

module hook(){
	translate([0,0,(HookInnerDiameter/2+WallThickness)]) rotate([-90,0,0]) difference(){
		hull(){
			cylinder(r=(HookInnerDiameter/2+WallThickness),h=WallThickness*2);
			translate([-(HookInnerDiameter/2+WallThickness),0,0]) cube([HookInnerDiameter+WallThickness*2,(HookInnerDiameter/2+WallThickness),WallThickness*2]);
		}
		cylinder(r=HookInnerDiameter/2,h=WallThickness*2);
	}
}