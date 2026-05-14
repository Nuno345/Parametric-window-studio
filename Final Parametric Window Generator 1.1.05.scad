//////////////////////////////////////////////////////////////
// ULTIMATE PARAMETRIC WINDOW GENERATOR
// Designed for OpenSCAD Customizer
//////////////////////////////////////////////////////////////

/* [1. Window Size] */
window_width = 30;      // [10:1:200]
window_height = 40;     // [10:1:200]
depth = 1.6;            // [0.6:0.2:10]

/* [2. Grid Layout] */
columns = 3;            // [1:1:10]
rows = 3;               // [1:1:10]

/* [3. Advanced Proportions] */
// Turn ON to make the top/bottom rows different sizes
enable_custom_proportions = false; 
// Size of the TOP panes
top_pane_size = 0.5;    // [0.3:Very Short, 0.5:Short, 1.0:Standard, 1.5:Tall, 2.0:Very Tall]
// Size of the BOTTOM panes
bottom_pane_size = 0.5; // [0.3:Very Short, 0.5:Short, 1.0:Standard, 1.5:Tall, 2.0:Very Tall]

/* [4. Architectural Details] */
enable_arch = false;        
arch_height = 15;       // [2:1:50]
enable_sill = true;        
sill_depth = 2;         // [0:0.5:10]
sill_height = 1;        // [0:0.5:5]

/* [5. Frame Thickness (Advanced)] */
frame_thickness = 3;    // [0.4:0.5:10]
muntin_thickness = 0.8; // [0.3:0.1:5]
cornice_overhang = 1.2; // [0:0.1:5]
cornice_height = 1.6;   // [0.5:0.1:5]

//////////////////////////////////////////////////////////////
// GENERATOR ENGINE (Do not edit below)
//////////////////////////////////////////////////////////////

// 1. Calculate effective inner dimensions so overall bounds match requested width & height perfectly
eff_w = window_width - (2 * cornice_overhang);

bottom_prot = enable_sill ? sill_depth : cornice_overhang;
top_prot = enable_arch ? (arch_height + cornice_overhang * (arch_height / (eff_w / 2))) : cornice_overhang;

eff_h = window_height - bottom_prot - top_prot;

generate_window();

module generate_window(){
    // 2. Shift the entire object so bottom-left is exactly at [0,0,0]
    translate([cornice_overhang, bottom_prot, 0])
    union(){
        if(enable_arch == false) flat_window();
        else arched_window();
        if(enable_sill == true) window_sill();
    }
}

module flat_window(){
    decorative_frame();
    muntins(false);
}

module arched_window(){
    union(){
        decorative_frame(true); 
        translate([eff_w/2, eff_h, 0])
        scale([1, arch_height / (eff_w/2), 1]) {
            difference() {
                cylinder(h=cornice_height, r=eff_w/2 + cornice_overhang, $fn=80);
                translate([0,0,-0.1]) cylinder(h=cornice_height+0.2, r=eff_w/2, $fn=80);
                translate([-eff_w, -eff_w, -1]) cube([eff_w*2, eff_w, cornice_height+2]);
            }
            difference() {
                cylinder(h=depth, r=eff_w/2, $fn=80);
                translate([0,0,-0.1]) cylinder(h=depth+0.2, r=(eff_w/2) - frame_thickness, $fn=80);
                translate([-eff_w, -eff_w, -1]) cube([eff_w*2, eff_w, depth+2]);
            }
        }
        intersection(){
            muntins(true);
            union(){
                cube([eff_w, eff_h, depth]);
                translate([eff_w/2, eff_h, 0])
                    scale([1, arch_height / (eff_w/2), 1])
                        cylinder(h=depth, r=(eff_w/2) - frame_thickness, $fn=80);
            }
        }
    }
}

module decorative_frame(is_arch = false){
    union(){
        difference(){
            cube([eff_w, eff_h, depth]);
            translate([frame_thickness, frame_thickness, -0.1])
            cube([eff_w - 2*frame_thickness, eff_h - 2*frame_thickness + (is_arch ? frame_thickness + 0.1 : 0), depth + 0.2]);
        }
        if (cornice_overhang > 0) {
            translate([-cornice_overhang, -cornice_overhang, 0])
            difference(){
                cube([eff_w + 2*cornice_overhang, eff_h + 2*cornice_overhang - (is_arch ? cornice_overhang : 0), cornice_height]);
                translate([cornice_overhang, cornice_overhang, -0.1])
                cube([eff_w, eff_h + (is_arch ? cornice_overhang + 0.1 : 0), cornice_height + 0.2]);
            }
        }
    }
}

module muntins(is_arch = false){
    // Vertical bars
    if(columns > 1){
        pane_w = (eff_w - 2*frame_thickness) / columns;
        for(i = [1 : columns-1]) {
            translate([frame_thickness + pane_w*i - muntin_thickness/2, frame_thickness, 0])
            cube([muntin_thickness, eff_h - 2*frame_thickness + (is_arch ? arch_height : 0), depth]);
        }
    }

    // Horizontal bars
    if(rows > 1){
        inner_h = eff_h - 2*frame_thickness;
        
        // Calculate units
        total_units = (enable_custom_proportions == false) ? rows :
                      (rows == 2) ? (top_pane_size + bottom_pane_size) :
                      (top_pane_size + bottom_pane_size + (rows - 2));
                      
        unit_h = inner_h / total_units;

        for(j = [1 : rows - 1]) {
            y_pos = (enable_custom_proportions == false) ? 
                    (frame_thickness + j * unit_h) :
                    (frame_thickness + (bottom_pane_size * unit_h) + ((j - 1) * unit_h));

            translate([frame_thickness, y_pos - muntin_thickness/2, 0])
            cube([eff_w - 2*frame_thickness, muntin_thickness, depth]);
        }
    }
}

module window_sill(){
    translate([-cornice_overhang, -sill_depth, 0])
    cube([eff_w + cornice_overhang*2, sill_depth, sill_height]);
}