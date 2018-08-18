include <hydroponics.scad>

z = 80;                     //box height

xd = 1;                     //number of x planters
yd = 1;                     //number of y planters

wt = 20;                    //water level from top

sq=0;                       //square
rn=1;                       //round

rotate(90)
    finish();

translate([x*2, 0, 0]) {
  lid();
}
