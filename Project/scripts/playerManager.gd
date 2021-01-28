extends KinematicBody2D

export(String, "QUESTS", "REWARDS") var my_group = "QUESTS"

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(my_group)



#func _process(delta):
#	pass
