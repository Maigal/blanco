/// room restart triggered by death
repeat (100) instance_create_depth(x,y,-1000,oBlood);
global.exploded = true;
instance_destroy();