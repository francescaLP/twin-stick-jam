extends CharacterBody3D


@export var SPEED = 6
@export var JUMP_VELOCITY = 4.5
@export var bulletPrefab = load("res://assets/bullet.tscn")
@export var cooldown = 2.0
var cooldown_timer = 0.0
var loaded = false

var model
var shootDir = Vector2.ZERO;

func shoot_bullet():
	var newBullet = bulletPrefab.instantiate()
	get_parent().add_child(newBullet)
	newBullet.position = position
	newBullet.rotation.y = shootDir.angle()



func _ready() -> void:
	model = get_node("Pivot")


func _point_and_shoot() -> void:
	if Input.is_action_pressed("shoot_left"):
		shootDir.y = 1
	elif Input.is_action_pressed("shoot_right"):
		shootDir.y = -1
	else:
		shootDir.y = 0
	
	if Input.is_action_pressed("shoot_forward"):
		shootDir.x = 1
	elif Input.is_action_pressed("shoot_back"):
		shootDir.x = -1
	else:
		shootDir.x = 0
	
	if shootDir != Vector2.ZERO and cooldown_timer <= 0:
		shoot_bullet()
		cooldown_timer = cooldown
	model.rotation.y = shootDir.angle()
	
	


func _physics_process(delta: float) -> void:
	if cooldown_timer > 0:
		cooldown_timer -= .1
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	_point_and_shoot()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
