extends CanvasLayer
#CONST
const  ICON_ROUTE = "res://assets/gui/img/icons_gui_%s.png"
const  POSITION_KEY = Vector2(400,8)
const  SPRITE_KEY   = Vector2(10,0)
const  CENTER_KEY   = Vector2(195,8)
#VAR
var request_notifications = []
var tweens = []
var keys   = []
var win
var isPlaying = true
#SIGNALS
signal orden_npc(status)

func _ready():
	pass

func _on_npc_add_notification(status, number):
	var new_key = $keyReward.duplicate() if status else  $keyQuest.duplicate() 
	keys.push_back(new_key)
	add_child(new_key)
	new_key.position = POSITION_KEY + (SPRITE_KEY * number)
	create_tween(new_key, number)
	var new_notification     = TextureRect.new()
	new_notification.texture = load(ICON_ROUTE % str(status))
	request_notifications.push_back(new_notification)

func _on_npc_delete_notification():
	var first_notification = $hbcNotification.get_children().pop_front()
	$hbcNotification.remove_child(first_notification)

func _on_btn_pressed():
	if isPlaying:
		$effectPlayer.queue("KET_TEXT2")
		emit_signal("orden_npc", 0)

func _on_btn2_pressed():
	if isPlaying:
		$effectPlayer.queue("KET_TEXT")
		emit_signal("orden_npc", 1)

func create_tween(element, n):
#	if !tweens.empty():
#		var tween = new_tween()
#		tween.interpolate_property(element, "position", element.position, CENTER_KEY + (SPRITE_KEY * n) , 2 , Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#		tween.start()
#		if tweens.front().is_active():
#			pass
#		else:
#			pass
#	else:
	var tween = new_tween()
	tween.interpolate_property(element, "position", element.position, CENTER_KEY + (SPRITE_KEY * n) , 2 , Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func new_tween():
	var tween = Tween.new()
	add_child(tween)
	tweens.push_back(tween)
	tween.connect("tween_completed", self, "_on_tween_end")
	return tween

func _on_tween_end(object,_key):
	$hbcNotification.add_child(request_notifications[keys.find(object)])
	object.hide()

func _on_npcCommon_next_interface(status):
	win       = status
	isPlaying = false
	$vbcNext/labelNext.text = "VICTORY" if win else "DEFEAT"
	$effectPlayer.play("NEXT_SHOW")

func _on_btn3_pressed():
	$effectPlayer.queue("KET_TEXT3")
	$effectPlayer.queue("NEXT_HIDE")
func _on_effectPlayer_animation_finished(anim_name):
	match anim_name:
		"NEXT_HIDE":
			if win:
				get_tree().change_scene(get_parent().next_scene)
			else:
				get_tree().reload_current_scene()
		_:
			pass
