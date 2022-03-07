extends Node2D

onready var playerDetection = $playerDetection
var closed = true
onready var potion = preload("res://assets/potion.tscn")

func _process(_delta):
	if closed and Input.is_action_just_pressed("interaction"):
		if playerDetection.can_see_player():
			closed = false
			$AudioStreamPlayer.play()
			$AnimatedSprite.play("open")
			add_child(potion.instance())
