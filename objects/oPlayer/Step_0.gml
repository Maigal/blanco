// Player input

key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_jump = keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_space);
key_jump_release =  keyboard_check_released(vk_up) || keyboard_check_released(vk_space);

// Calculate Movement
var dir = key_right - key_left;


// Acceleration

//hsp = dir * moveSpeed;

if (hsp < max_hsp) && (hsp > -max_hsp) {
	if (place_meeting(x, y+1, oSolid)) {
		hsp += dir * accel;
	} else {
		if ( (key_left && hsp >= -(max_hsp / 2)) || (key_right && hsp <= (max_hsp / 2)) ){
			hsp += dir * accel;
		}
	}
	
}
else if (hsp >= max_hsp) {
    if (key_right) {
        hsp = max_hsp;
    } else {
        hsp -= 1
    }
} else if (hsp <= -max_hsp) {
    if (key_left) {
        hsp = -max_hsp;
    } else
    {
        hsp += 1;
    }
}
if (hsp > 0) && (key_left = 0) && (key_right = 0) {hsp -= 0.25}

if (hsp < 0) && (key_left = 0) && (key_right = 0) {hsp += 0.25}


// Gravity

vsp += grv;

if (place_meeting(x, y+1, oSolid) && key_jump) {
	vsp = -jump;
}

if(key_jump_release) {
	vsp = vsp / 2;
}

//Wall Jumps
if ((vsp < 0 || state  == "wallSlide") && place_meeting(x-1,y,oSolid)) && (!place_meeting(x+1,y,oSolid) && lastWallJump != "left")  // Wal jump left
{
    if (key_jump) && (!place_meeting(x,y+1,oSolid))
    {
        vsp = -7;
        hsp += 8;
		lastWallJump = "left";
    }
}

if ((vsp < 0 || state  == "wallSlide") && place_meeting(x+1,y,oSolid)) && (!place_meeting(x-1,y,oSolid) && lastWallJump != "right") // Wal jump right
{
    if (key_jump) && (!place_meeting(x,y+1,oSolid))
    {
        vsp = -7;
        hsp -= 8;
		lastWallJump = "right";
    }
}

//Wall Slides Left
if (key_left) && (vsp > 0) && (place_meeting(x-1,y,oSolid)) && (!place_meeting(x,y+1,oSolid)) && lastWallJump != "left" {
    if (vsp <= 7) && (vsp > 1.5) { vsp -= 1} ;
    if (vsp <= 7)  && (vsp > 0) { grv = .05 };
	state = "wallSlide";
	image_xscale = 1;
	part_emitter_region(Sname,emitter1,x-10,x-10,bbox_bottom,bbox_bottom,ps_shape_ellipse,1);
	part_emitter_stream(Sname,emitter1,particle1,1);
}
if (key_left && (place_meeting(x-1,y,oSolid)) && (!place_meeting(x,y+1,oSolid))) {
    grv = normal_grav;
}
if (key_left = 0) {
    grv = normal_grav;
}

//Wall Slides Right
if (key_right) && (vsp > 0) && (place_meeting(x+1,y,oSolid)) && (!place_meeting(x,y+1,oSolid)) && lastWallJump != "right" {
    if (vsp <= 7) && (vsp > 1.5) { vsp -= 1} ;
    if (vsp <= 7)  && (vsp > 0) { grv = .05 };
	state = "wallSlide";
	image_xscale = -1;
	part_emitter_region(Sname,emitter1,x+10,x+10,bbox_bottom,bbox_bottom,ps_shape_ellipse,1);
	part_emitter_stream(Sname,emitter1,particle1,1);
}
if (key_right && (place_meeting(x+1,y,oSolid)) && (!place_meeting(x,y+1,oSolid))) {
    grv = normal_grav;
}
if (key_right = 0) {
    grv = normal_grav;
}



// Horizontal Collision

if (place_meeting(x+hsp, y ,oSolid)){
	while (!place_meeting(x+sign(hsp), y, oSolid)) {
		x = x + sign(hsp);
	}
	if (state == "dead" && !exploded) {
		repeat (100) instance_create_depth(x,y,-1000,oBlood);
		global.exploded = true;
		instance_destroy();
	}
	hsp = 0;
}

x = x + hsp;

// Vertical Collision
if (place_meeting(x, y+vsp ,oSolid)){
	while (!place_meeting(x, y+sign(vsp), oSolid)) {
		y = y + sign(vsp);
	}
	vsp = 0;
	lastWallJump = "";
}

y = y + vsp;




// Animation

if (state != "dead") {
	if (state != "wallSlide") {
		if (!place_meeting(x,y+1,oSolid)) {
			sprite_index = sPlayerAir;
			image_speed = 0;
			if (sign(vsp) > 0) {
				image_index = 1;
			} else {
				image_index = 0;
			}
		} else {
			image_speed = 1;
			if (hsp == 0) {
				sprite_index = sPlayer;
			} else {
				sprite_index = sPlayerRun;
			}
		}
	} else {
		sprite_index = sPlayerWallSlide;
		image_speed = 1;
	}
} else {
	sprite_index = sPlayerDead;
	//if (image_index == 3){
	//	image_speed = 0;
	//} else {
	//	image_speed = 1;
	//}
	
}




if (hsp != 0) {
	image_xscale = sign(hsp);
}


// State
if(global.death == 0) {
	if (vsp > 0 && state != "wallSlide") {
	state = "fall";
	} else if (vsp < 0) {
		state = "jump";
	} else if (vsp = 0) {
		state = "grounded";
	}
} else {
	state = "dead"
}


if(state != "wallSlide") {
	part_emitter_clear(Sname,emitter1);
}

if (global.deathAngle != 0 && global.death == 0) {
	global.death = 1;
	if (vsp > 0) {
		vsp = -30;
		if (hsp < 0) {
			hsp = +30;
		} else if (hsp > 0) {
			hsp = -30;
		}
	} else if (vsp < 0) {
		vsp = -5;
		if (hsp < 0) {
			hsp = +30;
		} else if (hsp > 0) {
			hsp = -30;
		}
	} else { 
		if (hsp < 0) {
			hsp = +30;
		} else if (hsp > 0) {
			hsp = -30;
		}
	}
	
	alarm[0] = 30;
	
	oControl.alarm[0] = 120;
}
