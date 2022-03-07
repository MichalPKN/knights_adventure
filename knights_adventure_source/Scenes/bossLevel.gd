extends Node2D

onready var enemy = preload("res://enemy/smallOrc.tscn")
onready var exit = preload("res://Scenes/GameExit.tscn")
onready var timer = $Timer

func _ready():
	randomize()

func _on_Timer_timeout():
	var enemy_instance = enemy.instance()
	add_child(enemy_instance)
	var x = rand_range(312, 712)
	var y = rand_range(-120, 216)
	enemy_instance.position = Vector2(x, y)
	enemy_instance.animationSpawn.play("spawn")


func _on_Boss_game_finish():
	timer.stop()
	var exit_instance = exit.instance()
	call_deferred("add_child", exit_instance)
	call_deferred("move_child", exit_instance, 3)
	exit_instance.position = Vector2(496, 32)

