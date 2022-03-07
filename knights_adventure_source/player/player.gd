extends KinematicBody2D


var velocity = Vector2()
export var acceleration = 1100
export var speed = 115
export var friction = 1100

onready var hurtbox = $hurtbox
onready var sword = $sword
onready var swordAnimation = sword.get_node("SwordAnimationPlayer")
onready var stats = $playerStats
onready var animatedSprite = $AnimatedSprite
onready var animationHit = $AnimationHit
onready var animationDie = $AnimationDie
onready var audioDie = $AudioDie
onready var audio = $AudioStreamPlayer


func _ready():
	animatedSprite.play()

func _physics_process(delta):
	var input_vector = Vector2()
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	if input_vector.length() > 0:
		animatedSprite.animation = "walk"
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		animatedSprite.animation = "idle"
		velocity = velocity.move_toward(Vector2(), friction * delta)
	velocity = move_and_slide(velocity)
	
	if get_global_mouse_position().x < global_position.x:
		animatedSprite.flip_h = true
		sword.scale.y = -1
		sword.position.x = -2
	else:
		animatedSprite.flip_h = false
		sword.scale.y = 1
		sword.position.x = 2
	
	sword.look_at(get_global_mouse_position())
	if Input.is_action_pressed("attack"):
		swordAnimation.play("attack")


func _on_hurtbox_area_entered(_area):
	playerStats.health -= 1
	if playerStats.health <= 0:
		audioDie.play()
		animationDie.play("Die")
		yield(animationDie, "animation_finished")
		playerStats.health = playerStats.max_health
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	audio.play()
	hurtbox.start_invincibility(0.6)


func _on_hurtbox_invincible_started():
	animationHit.play("start")


func _on_hurtbox_invincible_ended():
	animationHit.play("stop")
