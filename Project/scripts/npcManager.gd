extends KinematicBody2D
#CONST
const  DATA        = preload("res://scripts/dataManager.gd")
#VAR
var request_player = []

func _ready():
	$labelStateFix.text = "Oh...perdi mi codigo!"

func _on_area2DVision_body_entered(body):
	if   body.is_in_group(DATA.get_key_status(0)):
		$labelStateFix.text = "DAR QUEST"
		$questIcon.show()
		$rewardIcon.hide()
	elif body.is_in_group(DATA.get_key_status(1)):
		$labelStateFix.text = "DAR REWARDS"
		$questIcon.hide()
		$rewardIcon.show()
	else:
		$labelStateFix.text = "FIX"

func _on_area2DInteraction_body_entered(body):
	# asociar el jugador detectado a listado de request
	request_player.append(body)
	body.waiting(true)

func _on_HUD_orden_npc(status):
	if !request_player.empty():
		var key_status = DATA.get_key_status(status)
		if request_player.back().is_in_group(key_status):
			var player = request_player.pop_back()
			player.set_status(false)
