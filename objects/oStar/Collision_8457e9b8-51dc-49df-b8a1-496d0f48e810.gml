var bbox_left_other = other.bbox_left;
var bbox_top_other = other.bbox_top;
var bbox_right_other = other.bbox_right;
var bbox_bottom_other = other.bbox_bottom;

collision_x = (bbox_left - bbox_right_other)  / 2 + bbox_right_other;
collision_y = (bbox_top -  bbox_bottom_other) / 2 + bbox_bottom_other;



with (other) {
	//room_restart();
	other.vsp = -30;
	other.hsp = -30;
}

if (!triggered) {
	global.playerDeathX = collision_x;
	global.playerDeathY = collision_y;
	global.trapDeathX = x;
	global.trapDeathY = y;
	global.deathAngle = point_direction(trapDeathX, trapDeathY, playerDeathX, playerDeathY);
	repeat (50) instance_create_depth(global.playerDeathX,global.playerDeathY,-1000,oBlood);
	triggered = true;
}



