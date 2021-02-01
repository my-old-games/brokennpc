extends Node2D
#EXPORTS
export(int)          var level_defeat
export(int)          var level_win
export(String)       var next_scene


func _ready():
	pass # Replace with function body.

func stop_music():
	$music.stop()

func get_requests_size():
	return $npcCommon.request_player.size()
