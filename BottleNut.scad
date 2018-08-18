include <BottleThread.scad>

dmax = ThreadOuterDiameter*2;

//knob_thread();

module knob(l=LidHeight,w=WallThickness,d=dmax,td=ThreadOuterDiameter){
    a=d/sqrt(2); //kantenlänge
    d2=d*0.43;   //knubbel
    d3=a/2;         //knubbel-aussparung
    o=a/2-d2/2;     //knubbel-offset
    o2=a/2-d2*0.05; //aussparungs-offset
    difference()
    {
        union(){
            cylinder(d=td+w*3,h=l);
            hull()
            {
                translate([-o,0,0])
                    cylinder(d=d2,h=l);
                translate([o,0,0])
                    cylinder(d=d2,h=l);
            }
            hull(){
                translate([0,o,0])
                    cylinder(d=d2,h=l);
                translate([0,-o,0])
                    cylinder(d=d2,h=l);
            }
        }
        translate([o2,o2,0])
            cylinder(d=d3,h=l);
        translate([-o2,o2,0])
            cylinder(d=d3,h=l);
        translate([-o2,-o2,0])
            cylinder(d=d3,h=l);
        translate([o2,-o2,0])
            cylinder(d=d3,h=l);
    }
}

module knob_thread(l=LidHeight,w=WallThickness,d=dmax,td=ThreadOuterDiameter){
	/* render() */
    difference(){
//		cylinder(r=ThreadOuterDiameter/2+w,h=l);
        knob(l=l,w=w,td=td,d=d);
        translate([0,0,-ThreadPitch]) nthread(l=l*2,d=td);
        cylinder(r=td/2-w, h=l);
//	cylinder(r=ThreadOuterDiameter/2, h=l+1);
	}
}
