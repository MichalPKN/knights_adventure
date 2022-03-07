extends Node2D

onready var playerDetection = $playerDetection
var type = randi() % 2 

func _ready():
	randomize()
	if type:
		$Sprite.frame = 1
	else:
		$Sprite.frame = 0
		type = playerStats.max_health

func _process(_delta):
	if Input.is_action_just_pressed("interaction"):
		if playerDetection.can_see_player():
			playerStats.health += type
			queue_free()
