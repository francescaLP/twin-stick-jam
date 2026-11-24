extends CharacterBody3D


@export var SPEED = 5.0
@export var HEALTH = 1
var text_obj
var move_dir = Vector2(0,0);
signal damaged
signal destroyed

func _ready() -> void:
	text_obj = get_node("../../GUI/Score")
	destroyed.connect(text_obj._on_enemy_destroyed)
	

	

func destroy() -> void:
	destroyed.emit()
	queue_free()
	
func take_damage(damage:int) -> void:
	HEALTH -= damage
	damaged.emit()
	if(HEALTH <= 0):
		destroy()
	


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := (transform.basis * Vector3(move_dir.x, 0, move_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
