#ENUMS
enum STATUS {QUESTS,REWARDS}
enum DIRECCTIONS {LEFT, RIGHT}
#CONST
const  LEFT  = Vector2.LEFT
const  RIGHT = Vector2.RIGHT
#STATIC FUNC
static func get_key_status(status):
	return STATUS.keys()[status]


