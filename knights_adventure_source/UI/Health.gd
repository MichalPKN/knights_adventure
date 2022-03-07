extends Control

var hearts = 2 setget set_hearts
var max_hearts = 2 setget set_max_hearts
onready var heartEmpty = $heartEmpty
onready var heartFull = $heartFull
var playSound = false

func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heartEmpty != null: 
		heartEmpty.rect_size.x = max_hearts * 17


func set_hearts(value):
	if value >= hearts and playSound:
		$AudioStreamPlayer.play()
	hearts = clamp(value, 0, max_hearts)
	if heartFull != null: 
		heartFull.rect_size.x = hearts * 17

func _ready():
	self.max_hearts = playerStats.max_health
	self.hearts = playerStats.health
	playSound = true
# warning-ignore:return_value_discarded
	playerStats.connect("max_health_changed", self, "set_max_hearts")
# warning-ignore:return_value_discarded
	playerStats.connect("health_changed", self, "set_hearts")
