/// draw the surface

if (!surface_exists(global.surface_blood)) {
	global.surface_blood = surface_create(room_width, room_height);
} else {
	draw_surface(global.surface_blood, 0, 0);
}