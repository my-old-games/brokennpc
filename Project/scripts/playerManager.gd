extends KinematicBody2D

#FLAGS
var flag_wait = false
#EXPORTS
export(String, "QUESTS", "REWARDS") var my_group = "QUESTS"
export(Vector2)   var my_speed
var my_dir = Vector2.RIGHT


func _ready():
	add_to_group(my_group)

func _physics_process(_delta):
	if !flag_wait: 
		move_and_slide(my_speed*my_dir)

func waiting(status):
	flag_wait = status
