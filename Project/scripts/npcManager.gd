extends KinematicBody2D
#CONST
const  DATA        = preload("res://scripts/dataManager.gd")
const  ICON_ROUTE = "res://assets/gui/img/icons_%s.png"
#VAR
var request_player = []
var attend_request
#SIGNALS
signal add_notification(status, number)
signal delete_notification
signal next_interface(status) 

func _ready():
	$labelStateFix.text = "Oh...perdi mi codigo!"
	$animatedSprite.play("PANIC")
	$effectPlayer.queue("BLINK_DIALOG")
	attend_request = 0

func _on_area2DVision_body_entered(body):
	test_flip(body)
	var next_size = request_player.size() + 1
	if   body.is_in_group(DATA.get_key_status(0)):
		set_icon_status(0)
		$animatedSprite.play("IDLE")
		emit_signal("add_notification", 0, next_size)
	elif body.is_in_group(DATA.get_key_status(1)):
		set_icon_status(1)
		$animatedSprite.play("IDLE")
		emit_signal("add_notification", 1, next_size)
	else:
		pass

func _on_area2DInteraction_body_entered(body):
	# asociar el jugador detectado a listado de request
	request_player.push_back(body)
	# el jugador ahora esta esperando
	body.waiting(true)
	if(defeat_condition()):
		shutdown()
		$animatedSprite.play("DEFEAT")

func _on_HUD_orden_npc(status):
	if !request_player.empty():
		var key_status = DATA.get_key_status(status)
		if request_player.front().is_in_group(key_status):
			var player = request_player.pop_front()
			test_flip(player)
			set_status_animation(status)
			player.set_status(false)
			emit_signal("delete_notification")
			attend_request += 1
			if(win_condition()):
				$animatedSprite.play("VICTORY")

func set_status_animation(status):
	match status:
		0:
			$animatedSprite.play("QUEST")
		1:
			$animatedSprite.play("REWARD")

func set_icon_status(status):
	$statusIcon.texture = load(ICON_ROUTE % str(status))
	$effectPlayer.queue("BLINK_STATUS")

func _on_animatedSprite_animation_finished():
	match $animatedSprite.get_animation():
		"PANIC":
			print("GAME START")
		"DEFEAT":
			print("GAME OVER")
			emit_signal("next_interface",false)
			#get_tree().set_pause(true)
		"VICTORY":
			print("WIN")
			emit_signal("next_interface",true)
			#get_tree().set_pause(true)
		_:
			$animatedSprite.play("IDLE")

func win_condition():
	return get_parent().level_win    == attend_request

func defeat_condition():
	return get_parent().level_defeat == request_player.size()

func shutdown():
	$area2DInteraction.set_deferred("monitoring", false)
	$area2DVision.set_deferred("monitoring", false)
	
func fix_flip():
	$animatedSprite.position.x = $animatedSprite.position.x * -1 

func test_flip(body):
	if ($animatedSprite.flip_h != body.get_flip()):
		$animatedSprite.flip_h  = body.get_flip()
		fix_flip()
