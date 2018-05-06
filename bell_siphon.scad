/*
# original design by SnakeJayd
# https://www.thingiverse.com/thing:2119390
# shared by SnakeJayd under CC-BY, converted to GPLv3 for use in this project
*/

siphon_inner_radius = 25;
siphon_thickness = 3;
siphon_outer_radius = siphon_inner_radius + siphon_thickness;
siphon_height = 250;

snorkel_inner_radius = 5;
snorkel_thickness = 2;
snorkel_outer_radius = snorkel_inner_radius + snorkel_thickness;
snorkel_centre_displacement = 55;
snorkel_centre_from_siphon = snorkel_centre_displacement - siphon_outer_radius;
snorkel_outer_from_siphon_outer = snorkel_centre_from_siphon + snorkel_outer_radius;
//snorkel_base_height = 210;
snorkel_base_height = siphon_height - snorkel_outer_from_siphon_outer;

webbing_length = snorkel_centre_displacement - siphon_outer_radius - snorkel_outer_radius;
webbing_width = 2;
webbing_start_height = 50;
webbing_height = snorkel_base_height - webbing_start_height;


cup_inner_radius = 13;
cup_thickness = 2;
cup_outer_radius = cup_inner_radius + cup_thickness;
cup_height = 30;

mount_block_radius = 8;
mount_block_width = 45;
mount_block_vert_offset = 20;
mount_block_x_offset = siphon_outer_radius-(mount_block_radius);

mount_peg_length = 10;
mount_peg_radius = 2;
mount_peg_offset = mount_block_radius/2 + mount_block_x_offset;

mount_ring_thickness = mount_peg_radius*2;
mount_ring_inner_radius = mount_block_width/2 + 2;
mount_ring_outer_radius = mount_ring_inner_radius + mount_ring_thickness;


$fn=100;
module hole_circle(inner, outer){
    difference(){
        circle(outer);
        circle(inner);
    }
}

module chunk() {
    translate([10,10,-40]) {
        cube(50,50,50);
    }
}

module siphon_cylinder (){
    difference(){
        linear_extrude(height = siphon_height){
            hole_circle(siphon_inner_radius, siphon_outer_radius);
        }
        chunk();
        rotate([0,0,90])
            chunk();
        rotate([0,0,180])
            chunk();
        rotate([0,0,270])
            chunk();
    }
}


module snorkel_cylinder (cylinder_height){
    linear_extrude(height = cylinder_height){
        hole_circle(snorkel_inner_radius, snorkel_outer_radius);
    }
}

module snorkel_base () {
    difference() {
        translate([snorkel_centre_displacement,0,0]){
            snorkel_cylinder(snorkel_base_height);
        }
        translate([snorkel_centre_displacement,0,mount_block_vert_offset-100]){
            cube([200,200,200], true);
        }

    }
}

module angle() {
    rotate([-90,0,0]){
        difference(){
            rotate_extrude() {
                translate([snorkel_centre_from_siphon,0,0]){
                        hole_circle(snorkel_inner_radius, snorkel_outer_radius);
                }
            }
            translate([-50,0,-50])
            cube(100,100,100);
            translate([-100,-90,-50])
            cube(100,100,100);
        }
    }
}

module webbing(){
    translate([siphon_outer_radius, -0.5 * webbing_width, webbing_start_height]){
        difference(){
            cube([webbing_length,webbing_width, webbing_height]);
            translate([0.5 * webbing_length, 1.5*webbing_width,0]){
                rotate([90,0,0]){
                    cylinder(r=webbing_length/2, h=2*webbing_width);
                }
            }
            translate([0.5 * webbing_length, 1.5*webbing_width,webbing_height]){
                rotate([90,0,0]){
                    cylinder(r=webbing_length/2, h=2*webbing_width);
                }
            }
        }
    }
}

module mount_points() {
    difference() {
        translate([mount_block_x_offset, 0.5 * mount_block_width, mount_block_vert_offset]) {
            rotate([90,0,0]){
                difference(){
                    cylinder(r=mount_block_radius, h=mount_block_width);
                    translate([mount_block_radius/2,0,-50]) {
                        cylinder(r=mount_peg_radius+1, h=100);
                    }
                }
            }
        }
        cylinder(r=siphon_inner_radius, h=siphon_height);
    }
}

module lid() {
    translate([0,0,siphon_height-siphon_thickness]) {
        cylinder(r=siphon_outer_radius, h=siphon_thickness);
    }
}

module complete() {
    difference() {
        siphon_cylinder();
        translate([0,0,snorkel_base_height + snorkel_centre_from_siphon]){
            rotate([0,90,0]){
                cylinder (r=snorkel_inner_radius, h=siphon_outer_radius + 1);
            }
        }
    }
    snorkel_base ();
    translate([siphon_outer_radius, 0, snorkel_base_height]){
        angle();
    }
    difference(){
        translate([0,0,snorkel_base_height + snorkel_centre_from_siphon]){
            rotate([0,90,0]){
                snorkel_cylinder (siphon_outer_radius);
            }
        }
        cylinder(r=siphon_inner_radius, h=siphon_height);
    }
    webbing();
    mount_points();
    lid();
}

complete();

module mount_pegs() {
    translate([0,mount_ring_outer_radius,mount_peg_radius]){
        rotate([90,0,0]){
            cylinder(r=mount_peg_radius, h=mount_peg_length);
        }
    }
    translate([0,-mount_ring_outer_radius,mount_peg_radius]){
        rotate([-90,0,0]){
            cylinder(r=mount_peg_radius, h=mount_peg_length);
        }
    }
}

module mount_ring() {
    difference(){
        translate([mount_peg_offset, 0, 0]) {
            difference() {
                difference(){
                    cylinder(r=mount_ring_outer_radius, h=mount_peg_radius*2);
                    translate([0,0,-0.5])
                        cylinder(r=mount_ring_inner_radius, h=mount_peg_radius*3);
                }
                translate([-100,-50,-2]){
                    cube([100,100,100]);
                }

            }
            mount_pegs();

        }
        translate([snorkel_centre_displacement-(0.3*cup_inner_radius), 0,0]){
            translate([0,0,cup_thickness]){
                cylinder(r=cup_inner_radius, h=cup_height);
            }
        }
    }
}

module cup() {
    translate([snorkel_centre_displacement-(0.3*cup_inner_radius), 0,0]){
        difference(){
            cylinder(r=cup_outer_radius, h=cup_height);
            translate([0,0,cup_thickness]){
                cylinder(r=cup_inner_radius, h=cup_height);
            }
        }
    }
    mount_ring();

}
//cup();
