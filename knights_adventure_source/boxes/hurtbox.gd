extends Area2D

var invincible = false setget set_invincible

signal invincible_started
signal invincible_ended

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincible_started")
	else:
		emit_signal("invincible_ended")

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func _on_Timer_timeout():
	self.invincible = false


func _on_hurtbox_invincible_started():
	collisionShape.set_deferred("disabled", true)


func _on_hurtbox_invincible_ended():
	collisionShape.set_deferred("disabled", false)
