extends Control

func _ready():
	$VBoxContainer/start.grab_focus()

func _on_start_pressed():
	playerStats.health = playerStats.max_health
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/LVL1.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_CheckBox_toggled(button_pressed):
	Music.stream_paused = not button_pressed
