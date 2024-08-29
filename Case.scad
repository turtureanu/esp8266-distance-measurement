$fs = 0.01;
PADDING = 2;

WALL_THICKNESS = 4;

BOX_W = 30 + 2*PADDING + WALL_THICKNESS; // Width (X)
BOX_L = 57 + 2*PADDING + WALL_THICKNESS; // Length (Y)
BOX_H = 35; // Height (Z)

CORNER_RADIUS = 2;

USB_HOLE_W = 10 + PADDING;
USB_HOLE_D = WALL_THICKNESS + PADDING;
USB_HOLE_H = 5 + PADDING;

SENSOR_HOLE_W = 8.5;
SENSOR_HOLE_D = 10;
SENSOR_HOLE_H = WALL_THICKNESS + PADDING;

PIN_DIAMETER = 2.9;
PIN_CORRECTION = 0.55 - WALL_THICKNESS - PADDING - 1 - 0.1;

// First box
translate([0,0,0]) {
    render() {
        difference() {
            // Walls
            linear_extrude(USB_HOLE_H + WALL_THICKNESS + 5)
                difference() {
                    offset(r=CORNER_RADIUS)
                        square([BOX_W, BOX_L], center = true);
                    offset(r=CORNER_RADIUS)
                        square([BOX_W - 2 * WALL_THICKNESS, BOX_L - 2 * WALL_THICKNESS], center = true);
                };
            // USB Micro-B hole
            translate([0, BOX_L / 2, USB_HOLE_H / 2 + WALL_THICKNESS + 5])
                cube([USB_HOLE_W, USB_HOLE_D, USB_HOLE_H], center = true);
            
            // Closing mechanism
            linear_extrude(USB_HOLE_H + WALL_THICKNESS + 5)
                difference() {
                    offset(r=CORNER_RADIUS)
                        square( [BOX_W, BOX_L], center = true );
                    offset(r=CORNER_RADIUS)
                        square( [BOX_W - WALL_THICKNESS, BOX_L - WALL_THICKNESS], center = true );
                }
        }
    }

    // Pins to hold the board in place
    translate([BOX_W / 2 + PIN_CORRECTION, BOX_L / 2 + PIN_CORRECTION, 0]) 
        linear_extrude(WALL_THICKNESS + USB_HOLE_H + 5)
            circle(d = PIN_DIAMETER);
    translate([- BOX_W / 2 -PIN_CORRECTION, - BOX_L / 2 - PIN_CORRECTION, 0]) 
        linear_extrude(WALL_THICKNESS + USB_HOLE_H + 5)
            circle(d = PIN_DIAMETER);
    translate([BOX_W / 2 + PIN_CORRECTION, - BOX_L / 2 - PIN_CORRECTION, 0]) 
        linear_extrude(WALL_THICKNESS + USB_HOLE_H + 5)
            circle(d = PIN_DIAMETER);
    translate([- BOX_W / 2 - PIN_CORRECTION, BOX_L / 2 + PIN_CORRECTION, 0]) 
        linear_extrude(WALL_THICKNESS + USB_HOLE_H + 5)
            circle(d = PIN_DIAMETER);

    // Bottom
    linear_extrude(WALL_THICKNESS) offset(r=CORNER_RADIUS) square( [BOX_W, BOX_L], center = true );
}

// Second box
translate([BOX_W + PADDING * 5, 0, 0]) {
    render() {
        difference() {
            // Walls
            linear_extrude(BOX_H)
                difference() {
                    offset(r=CORNER_RADIUS)
                        square([BOX_W, BOX_L], center = true);
                    offset(r=CORNER_RADIUS)
                        square([BOX_W - 2 * WALL_THICKNESS, BOX_L - 2 * WALL_THICKNESS], center = true);
                };
            // USB Micro-B hole
            translate([0, BOX_L / 2, BOX_H - USB_HOLE_H/2 - 5/2])
                cube([USB_HOLE_W, USB_HOLE_D, USB_HOLE_H + 5], center = true);
            
            // Closing mechanism
           translate([0, 0, BOX_H - USB_HOLE_H - 5]) linear_extrude(USB_HOLE_H + 5 + PADDING)
                    offset(r=CORNER_RADIUS)
                        square( [BOX_W - WALL_THICKNESS, BOX_L - WALL_THICKNESS], center = true );
    }
    }

    // Pins to hold the board in place
    translate([BOX_W / 2 + PIN_CORRECTION, - BOX_L / 2 - PIN_CORRECTION, 0]) 
        linear_extrude(BOX_H - USB_HOLE_H - 5)
            circle(d = PIN_DIAMETER);
    
    translate([BOX_W / 2 + PIN_CORRECTION, - BOX_L / 2 - PIN_CORRECTION + 36, 0]) 
        linear_extrude(BOX_H - USB_HOLE_H - 5)
            circle(d = PIN_DIAMETER);
    
    
   translate([- BOX_W / 2 - PIN_CORRECTION, - BOX_L / 2 - PIN_CORRECTION + 36, 0]) 
        linear_extrude(BOX_H - USB_HOLE_H - 5)
            circle(d = PIN_DIAMETER);

    translate([- BOX_W / 2 - PIN_CORRECTION, - BOX_L / 2 - PIN_CORRECTION, 0]) 
        linear_extrude(BOX_H - USB_HOLE_H - 5)
            circle(d = PIN_DIAMETER);


    translate([BOX_W / 2 + PIN_CORRECTION, BOX_L / 2 + PIN_CORRECTION, 0]) 
        linear_extrude(BOX_H - USB_HOLE_H - 5)
            circle(d = PIN_DIAMETER);
    
    translate([- BOX_W / 2 - PIN_CORRECTION, BOX_L / 2 + PIN_CORRECTION, 0]) 
        linear_extrude(BOX_H - USB_HOLE_H - 5)
            circle(d = PIN_DIAMETER);

   // Bottom
    difference() {
       linear_extrude(WALL_THICKNESS) offset(r=CORNER_RADIUS)
        square( [BOX_W, BOX_L], center = true );
       translate([-1, 36 / 2 - PIN_CORRECTION - BOX_L / 2, SENSOR_HOLE_H / 2])
        cube([SENSOR_HOLE_W, SENSOR_HOLE_D, SENSOR_HOLE_H], center = true);
    }
}