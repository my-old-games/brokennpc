extends CanvasLayer

signal orden_npc(status)

func _ready():
	pass # Replace with function body.

func _on_btnQuest_pressed():
	emit_signal("orden_npc", 0)

func _on_btnReward_pressed():
	emit_signal("orden_npc", 1)
