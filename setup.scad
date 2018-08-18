include <lib/hydroponics.scad>

z = 80;                     //box height

xd = 3;                     //number of x planters
yd = 3;                     //number of y planters

wt = 20;                    //water level from top

sq=1;                       //square
rn=0;                       //round

psq=0;                       //square
prn=1;                       //round

//inflow height
ih=15;

rotate(-90){
  //%finish();
  %finish_inset3();

  //translate([x+b,0,0])    //print
  translate([0,0,z])        //display
    lid_holes();
  translate([0,0,-w])       //stack
    lid_hole();

  setup();
}

module setup(){
  //waterlevel
  /* color("blue",0.5) %block(x-w*2,y-w*2,wb,b+w); */
  /* planters(); */
  //    translate([x/2-b/2,0,wb])
  //        rotate([0,0,180])
  //            floater();
  //    translate([x/2-b/2,0,wb+30])
  //        receiver_short();
  translate([(d+b)*(xd-1)/2,0,0]){
    translate([0,0,tl+w/2]){
      /* translate([0,0,-w-tl*2]) */
        /* knob_thread(tl,tt); */
        outlet();
      translate([0,0,5+tl])
        overflow();
      translate([0,0,wb-bh-ts-w+ts])
        inflow(ih);
      translate([0,0,wb-bh-ts-w+20])
        connector();
    }
  }
}
