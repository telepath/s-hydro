include <BottleThread.scad>
use <BottleNut.scad>

//wall width
w = 2;
//box height
z = 80;
//size of planter
d = 50;
//number of x planters
xd = 2;
//number of y planters
yd = 3;
//fine walls
f = 0.01;
//diameter of bottom hole
bd = 30;
//height of bottom inset
bh = 10;
//water level from top
wt = 20;
//square
sq=0;
//round
rn=1;
//square
psq=0;
//round
prn=1;
//drip nozzle in
n1=3;
//drip nozzle out
n2=1.5;
//thread slope length
ts=5;
//thread lenghth
tl = 8;
//ThreadOuterDiameter
t=ThreadOuterDiameter;
//treads wall thickness
tt=w*1.5;
//slope (distance)
//box width
b = 4*w;
x = (d+b*(2+rn))*xd;
//box length
y = (d+b*(2+rn))*yd;
//water level from bottom
wb = z-wt;

shift = (yd/2 - floor(yd/2))-0.5;

//%finish();
//%finish_inset1();

//translate([x+b,0,0])    //print
//translate([0,0,z])        //display
//    lid_holes();
//translate([0,0,-w])       //stack
//    lid_hole();

//planter();
/* outlet(); */
/* borev2(); */
//translate([0,0,5+tl+w])
    /* overflow(); */
//dummy_lid();

/* translate([0,0,-tl-w])
    female(); */
/* male(); */
//%bottom_inset();

module overflow(){
    h=wb-bh-ts-tl-w;
    /* render() */
        male();
    translate([0,0,ts])
        difference(){
            cylinder(d=bd+w*2,h=h-ts-tl-w);
            translate([0,0,-1])
                cylinder(d=bd,h=h-ts-tl-w+2);
        }
    translate([0,0,h-tl-w])
        female();
}

module outlet(){
//    render()
        difference(){
            male();
            borev2(90);
            borev2(270);
        }
        translate([0,0,ts])
            female();
}

module bore(r=0){
    rotate([0,0,r])
        translate([-bd/2-w*2,-w/2,w])
            rotate([0,15,0])
                cube([bd,w,w*1.5]);
}

module borev2(r=0){
    rotate([0,0,r])
        translate([-bd/2-w*1.3,0,w*1.5])
            rotate([0,110,0])
                cylinder(d1=n1,d2=n2,h=w*2.5+tt);
}

module male(){
    /* render() */
    {
        translate([0,0,-tl])
            inner_thread(tl,tt);
        difference(){
            cylinder(d=bd+2*w,h=ts);
            cylinder(d2=bd,d1=t-tt*2,h=ts);
            translate([0,0,-f])
                cylinder(d=t-tt*2,h=ts+2*f);
            translate([0,0,ts-f])
                cylinder(d=bd,h=2*f);
        }
    }
}

module female(h=tl+w){
        difference(){
            cylinder(d=bd+2*w,h=h);
            translate([0,0,-f])
              cylinder(d=t+w,h=h+2*f);
        }
        outer_thread(h,tt);
}

module nut(){
    translate([(d+b)*(xd-1)/2,0,0])
        knob_thread(tl,tt);
}

module finish_inset2(){
        difference(){
            finish();
            translate([(d+b)*(xd-1)/2,(d+b)*shift,0])
                cylinder(d=bd,h=w*2,center=true);
        }
}

module finish_inset1(){
    minkowski()
    {
        sphere(w/2,$fn=10);
        union(){
            difference()
            {
                    box(x,y,z,b);
                    translate([(d+b)*(xd-1)/2,(d+b)*shift,0]){
                      cylinder(d=bd+b*3,h=w*2*rn,center=true);
                      cube([bd+b*3,bd+b*3,w*2],center=true);
                    }
            }
            bottom_inset();
        }
    }
}

module bottom_inset(){
    xb=bd+b*3;
    zb=bh;
    fn=10;
    translate([(d+b)*(xd-1)/2,(d+b)*shift,0])
    difference(){
        translate([0,0,zb])
            rotate([180,0,0])
                box(xb,xb,zb,b*bh/z,rn=rn,sq=sq);
                /* box(xb,xb,zb,b*bh/z,rn=prn,sq=psq); */
        cylinder(d=bd+w,h=zb*2);
    }
}

module dummy_lid(){
    cylinder(d=d+w*2,h=w,center=true);
    translate([0,0,w])
        difference(){
            cylinder(d=d-w,h=w,center=true);
            cylinder(d=d-w*3,h=w,center=true);
        }
}

module finish_receiver(){
    difference()
    {
        finish();
        translate([x/2-30,0,wb+30])
            rotate([0,90,0])
                cylinder(d=w,h=50,$fn=10);
    }
    translate([x/2-b/2,0,wb+30])
//        receiver();
        receiver_short();
}

module receiver(){
    y = 26.92;
    x = 35.5;
    z = 31.99;
    translate([-5,-y/2,12])
        rotate([180,0,90])
            import("Non-Circulating-3Dponics/Receiver/3Dponics-Receiver.STL");
}

module receiver_short(){
    cut = 18.5;
    cone = 5;
    a = 7.5;
    b = 3;
    union(){
        difference()
        {
            receiver();
            receiver_cut();
        }
        translate([-cut+cone,0,0]) intersection()
        {
            receiver();
            translate([cut,0,0])
                receiver_cut();
        }
        translate([2.5+w*2,0,0])
            rotate([0,90,0])
                cylinder(r1=a,r2=b,h=cone,center=true);
    }
}

module receiver_cut(){
        translate([25+w*2,0,0])
            cube([50,50,50],center=true);
}

module floater(){
    y = 26.92;
    x = 69.7;
    z = 56.06;
    translate([x,-y/2,z*0.6])
        rotate([0,90,90])
            import("Non-Circulating-3Dponics/Floater V1/3Dponics-Floater-V1.STL");
}

module planter(){
    translate([-(d+w*2)/2,-(d+w*2)/2,z+w])
        rotate([-90,0,0])
            import("Non-Circulating-3Dponics/Planter Round/3Dponics-Round-Planter.STL");
}

module planters(){
    dist = d+b;
    difference()
    {
        translate([-dist*(xd-1)/2,-dist*(yd-1)/2,0])
            for(i = [0:xd-1])
                for(j = [0:yd-1])
                    translate([dist*i,dist*j,0]){
                        planter();
                    }
        translate([(d+b)*(xd-1)/2,(d+b)*shift,0])
            translate([-dist/2,-dist/2,b])
                    cube([dist,dist,z]);
    }
}

module lid_holes(){
    difference(){
        lid();
        inset(xd,yd,d,b);
    }
//    translate([(d+b)*(xd-1)/2,(d+b)*shift,0])
//        cube([d+b,d+b,w],center=true);
}

module lid_hole(){
    difference(){
        lid();
        translate([(d+b)*(xd-1)/2,(d+b)*shift,0]){
                    cylinder(r=d/2*rn,h=w*5,center=true);
                    cube([d*sq,d*sq,w*5],center=true);
        }
    }
}

module inset(x,y,d,b){
    dist = d+b;
    translate([-dist*(x-1)/2,-dist*(y-1)/2,0])
        for(i = [0:x-1])
            for(j = [0:y-1])
                translate([dist*i,dist*j,0]){
                    cylinder(r=d/2*prn,h=w*5,center=true);
                    cube([d*psq,d*psq,w*5],center=true);
                }
}

module finish(x=x,y=y,z=z,b=b,w=w,fn=20){
    minkowski() {
        sphere(w/2,$fn=fn);
        box(x,y,z,b);
    }
}

module box(x=x,y=y,z=z,b=b,rn=rn,sq=sq){
    difference(){
        block(x,y,z,b,rn,sq);
        translate([0,0,f])
            block(x-f,y-f,z,b,rn,sq);
    }
}

module block(x,y,z,b,rn,sq){
    linear_extrude(height=z,convexity=10,scale=[x/(x-b),y/(y-b)]){
        base_square((x-b)*sq,(y-b)*sq);
        base_round((x-b)*rn,(y-b)*rn);
    }
}

module border(x,y,w,z=f,fn=20){
    minkowski()
    {
        sphere(w/2,$fn=fn);
        linear_extrude(height=z,convexity=10){
            difference(){
                base_square(x*sq,y*sq);
                base_square((x-f)*sq,(y-f)*sq);
            }
            difference(){
                base_round(x*rn,y*rn);
                base_round((x-f)*rn,(y-f)*rn);
            }
        }
    }
}

module base_square(x,y){
    square([x,y],center=true);
}

module base_round(x,y){
    translate([0,-(y-x)/2,0]) hull()
    {
        circle(x/2);
        translate([0,y-x,0])
            circle(x/2);
    }
}

module lid(){
    difference(){
        union(){
            linear_extrude(height=w,convexity=10,center=true){
                base_square(x*sq,y*sq);
                base_round(x*rn,y*rn);
            }
            border(x,y,w*3);
        }
        translate([0,0,-w])
            border(x,y,w*1.1,w);
        translate([0,0,-w])
            cube([x*2,y*2,w],center=true);
    }
}