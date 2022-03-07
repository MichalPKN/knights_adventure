extends KinematicBody2D

signal game_finish

export var health = 3
export var speed = 75
export var friction = 200


enum{
	IDLE,
	CHASE
}

var knockback = Vector2()
var velocity = Vector2()
var state = IDLE 
onready var playerDetection = $playerDetection
onready var softCollision = $softCollision
onready var hurtbox = $hurtbox
onready var hitbox = $hitbox
onready var animatedSprite = $AnimatedSprite
onready var animationHit = $AnimationHit
onready var animationSpawn = $AnimationSpawn
onready var animationDie = $AnimationDie
onready var audio = $AudioStreamPlayer

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2(), friction * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			animatedSprite.play("idle")
			velocity = velocity.move_toward(Vector2(), friction * delta)
			if playerDetection.can_see_player():
				state = CHASE
		
		CHASE:
			animatedSprite.play("walk")
			var player = playerDetection.player
			if player != null:
				var direction = position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * speed, friction * delta)
			else:
				state = IDLE
			animatedSprite.flip_h = velocity.x < 0
			
#	if softCollision.is_colliding():
#		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)


func _on_hurtbox_area_entered(area):
	if "sword" in area.name:
		knockback = Vector2(120, 0).rotated(area.rotation)
	health -= area.damage
	audio.play()
	if health <= 0:
		animationDie.play("die")
		emit_signal("game_finish")
		yield(animationDie, "animation_finished")
		queue_free()
	else:
		hurtbox.start_invincibility(0.4)


func _on_hurtbox_invincible_started():
	animationHit.play("start")


func _on_hurtbox_invincible_ended():
	animationHit.play("stop")
