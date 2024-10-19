extends CharacterBody2D


var max_speed = 1000.0
var speed = 0
var speed_increase = 20.0
var last_input = null
var on_human = false
var human_object = null
var blood = 100
var distance_traveled = position.x

func on_ready():
	Global.blood = blood


func _process(_delta: float) -> void:
	if speed > 0:
		$AnimatedSprite2D.play("running")
	else:
		$AnimatedSprite2D.play("idle")
	Global.blood = blood
	if on_human:
		print("on human")
	distance_traveled = position.x

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if blood > 0:
		var arrow_input := Input.get_axis("ui_left", "ui_right")
		if Input.is_action_just_pressed("ui_up") and on_human:
			blood += 50
			on_human = false
			human_object.drain()
		if arrow_input and arrow_input != last_input:
			speed += speed_increase
			speed = min(speed, max_speed)
		else:
			speed -= 100 * delta
			speed = max(0, speed)
		last_input = arrow_input
		velocity.x = speed
		blood -= 10 * delta
	else:
		velocity.x = 0
		speed = 0
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("human"):
		on_human = true
		human_object = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("human"):
		on_human = false
		human_object = null
