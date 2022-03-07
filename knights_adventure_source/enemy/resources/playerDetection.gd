extends Area2D

var player = null

func can_see_player():
	return player != null


func _on_playerDetection_body_entered(body):
	if "player" in body.name:
		player = body


func _on_playerDetection_body_exited(body):
	if "player" in body.name:
		player = null
