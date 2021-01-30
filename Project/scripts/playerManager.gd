extends KinematicBody2D

#CONST
const  DATA        = preload("res://scripts/dataManager.gd")
#EXPORTS
export(DATA.STATUS)      var my_status
export(DATA.DIRECCTIONS) var my_direcction
export(Vector2)          var my_speed
#FLAGS
var flag_wait  = false
#VAR
var direcction 

func _ready():
	add_to_group(DATA.get_key_status(my_status))
	set_direcction()

func _physics_process(_delta):
	if !flag_wait:
		var speed =  my_speed * direcction
		move_and_slide(speed)

func waiting(status):
	flag_wait = status

func switch_dir():
	my_direcction = !my_direcction
	set_direcction()
	$animatedSprite.set_flip_h(!$animatedSprite.flip_h)

func set_direcction():
	direcction = DATA.RIGHT if my_direcction else DATA.LEFT

func set_status(status):
	waiting(status)
	switch_dir()


