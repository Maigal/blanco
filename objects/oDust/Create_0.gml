/// @description Insert description here
// You can write your code in this editor

Sname = part_system_create();

 particle1 = part_type_create();
part_type_sprite(particle1,sDust,1,0,0);
part_type_size(particle1,0.53,0.63,0,0);
part_type_scale(particle1,2.18,1.54);
part_type_color2(particle1,16777215,12632256);
part_type_alpha3(particle1,0.87,0.75,0.03);
part_type_speed(particle1,1,5,-0.07,0);
part_type_direction(particle1,80,100,0,0);
part_type_gravity(particle1,0,270);
part_type_orientation(particle1,0,0,0,0,1);
part_type_blend(particle1,1);
part_type_life(particle1,52,74);
emitter1 = part_emitter_create(Sname);
//part_emitter_region(Sname,emitter1,x,x,y,y,ps_shape_ellipse,1);
//part_emitter_stream(Sname,emitter1,particle1,1);
