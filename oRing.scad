include <lib/hydroponics.scad>

oring();

translate([t+w*2,0,0])
  oring(t=ti-w);
