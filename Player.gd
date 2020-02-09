extends KinematicBody2D

var velocity = Vector2()
var spriteDirection = "down"
const ACCELERATION = 3000
const MAX_SPEED = 300
var axis = Vector2.ZERO

func _physics_process(delta):
	axis = getInputAxis()
	
	if axis == Vector2.ZERO:
		applyFriction(ACCELERATION * delta)
	else:
		applyMovement(axis * ACCELERATION * delta)
	velocity = move_and_slide(velocity)
	
	checkSpriteDirection()
	
	print(axis)
	
	if axis != Vector2.ZERO:
		switchAnimation("walk")
	else:
		switchAnimation("idle")
	

	
func getInputAxis():
	axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func applyFriction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func applyMovement(acceleration):
	velocity += acceleration
	velocity = velocity.clamped(MAX_SPEED)
	velocity = velocity.clamped(MAX_SPEED)
	
func checkSpriteDirection():
	match axis:
		Vector2(-1, 0):
			spriteDirection = "left"
		Vector2(1, 0):
			spriteDirection = "right"
		Vector2(0, -1):
			spriteDirection = "up"
		Vector2(0, 1):
			spriteDirection = "down"
		

func switchAnimation(animation):
	var newAnim = str(animation, spriteDirection)
	if $AnimationPlayer.current_animation != newAnim:
		$AnimationPlayer.play(newAnim)
