extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal give_quest
signal give_reward

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_btnQuest_pressed():
	emit_signal("give_quest")

func _on_btnReward_pressed():
	emit_signal("give_reward")
