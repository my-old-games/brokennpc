extends CanvasLayer
#CONST
const  ICON_ROUTE = "res://assets/gui/img/icons_gui_%s.png"
#VAR
var request_notifications = []
#SIGNALS
signal orden_npc(status)

func _ready():
	pass

func _on_btnQuest_pressed():
	emit_signal("orden_npc", 0)

func _on_btnReward_pressed():
	emit_signal("orden_npc", 1)

func _on_npc_add_notification(status):
	var new_notification     = TextureRect.new()
	new_notification.texture = load(ICON_ROUTE % str(status))
	request_notifications.push_back(new_notification)
	$hbcNotification.add_child(new_notification)

func _on_npc_delete_notification():
	var first_notification = $hbcNotification.get_children().pop_front()
	$hbcNotification.remove_child(first_notification)
