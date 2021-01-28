extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var request_player = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_area2DVision_body_entered(body):
	if   body.is_in_group("QUESTS"):
		$labelStateFix.text = "DAR QUEST"
	elif body.is_in_group("REWARDS"):
		$labelStateFix.text = "DAR REWARDS"
	else:
		$labelStateFix.text = "FIX"

func _on_area2DInteraction_body_entered(body):
	# asociar el jugador detectado a listado de request
	request_player.append(body)
	body.waiting(true)

func _on_HUD_give_quest():
	if !request_player.empty():
		if request_player.back().is_in_group("QUESTS"):
			var player = request_player.pop_back()
			player.my_dir = Vector2.LEFT
			player.waiting(false)
			

func _on_HUD_give_reward():
	if !request_player.empty():
		if request_player.back().is_in_group("REWARDS"):
			var player = request_player.pop_back()
			player.my_dir = Vector2.LEFT
			player.waiting(false)
