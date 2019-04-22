hsp = 0;
max_hsp = 4;
vsp = 0;
grv = 0.4;
jump = 8;
accel = 0.5;
airAccel = 0.25;
normal_grav = 0.4;

lastWallJump = "";


state = "idle";


// DUST PARTICLES 

Sname = part_system_create();

particle1 = part_type_create();
part_type_shape(particle1,pt_shape_flare);
part_type_size(particle1,0.10,0.10,0.08,0);
part_type_scale(particle1,0.1,0.1);
part_type_color2(particle1,16777215,12632256);
part_type_alpha3(particle1,0.56,0.39,0.04);
part_type_speed(particle1,1,3,0,0);
part_type_direction(particle1,75,105,0,0);
part_type_gravity(particle1,0,270);
part_type_blend(particle1,0);
part_type_life(particle1,12,24);
emitter1 = part_emitter_create(Sname);







