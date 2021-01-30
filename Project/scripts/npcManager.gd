extends KinematicBody2D
#CONST
const  DATA        = preload("res://scripts/dataManager.gd")
const  ICON_ROUTE = "res://assets/gui/img/icons_%s.png"
#VAR
var request_player = []
#SIGNALS
signal add_notification(status)
signal delete_notification 

func _ready():
	$labelStateFix.text = "Oh...perdi mi codigo!"
	$effectPlayer.play("BLINK_DIALOG")

func _on_area2DVision_body_entered(body):
	if   body.is_in_group(DATA.get_key_status(0)):
		$effectPlayer.play("STATUS_HIDE")
		$statusIcon.texture = load(ICON_ROUTE % str(0))
		$effectPlayer.play("STATUS_SHOW")
		emit_signal("add_notification", 0)
	elif body.is_in_group(DATA.get_key_status(1)):
		$effectPlayer.play("STATUS_HIDE")
		$statusIcon.texture = load(ICON_ROUTE % str(1))
		$effectPlayer.play("STATUS_SHOW")
		emit_signal("add_notification", 1)
	else:
		pass

func _on_area2DInteraction_body_entered(body):
	# asociar el jugador detectado a listado de request
	request_player.push_back(body)
	body.waiting(true)

func _on_HUD_orden_npc(status):
	if !request_player.empty():
		var key_status = DATA.get_key_status(status)
		if request_player.front().is_in_group(key_status):
			var player = request_player.pop_front()
			player.set_status(false)
			emit_signal("delete_notification")

