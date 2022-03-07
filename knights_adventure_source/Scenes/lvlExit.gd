extends Node2D

onready var playerDetection = $playerDetection

func _process(_delta):
	if Input.is_action_just_pressed("interaction"):
		if playerDetection.can_see_player():
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/LVL" + str(int(get_tree().current_scene.name)+1) + ".tscn")
