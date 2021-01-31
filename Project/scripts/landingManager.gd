extends CanvasLayer



func _on_btnPlay_pressed():
	$effectPlayer.play("DROP_LABEL")


func _on_effectPlayer_animation_finished(anim_name):
	match anim_name:
		"DROP_LABEL":
			$hbcMain/vbcIntro/ccButton/btnPlay.set_disabled(true) 
			$effectPlayer.play("HIDE_ICON")
			$hbcMain/vbcNPC/ccNPC/AnimatedSprite.play("READ")
		"HIDE_ICON":
			 get_tree().change_scene("res://scenes/level/level0.tscn")
		
