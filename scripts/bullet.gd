extends Node3D

var cast
@export var speed:float = .2
var dir = Vector3(0,1,0);
var damage = 1
var pierce = 2

func damage_target(target:Object) -> void:
	target.take_damage(damage)
	pierce -= 1
	if pierce <= 0:
		queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cast = get_node("ShapeCast3D")
	pass # Replace with function body.
	
	
func _physics_process(delta: float) -> void:
	transform.origin -= transform.basis.z * speed
	if cast.is_colliding():
		for c in range(cast.get_collision_count()):
			if(pierce > 0):
				var enemy = cast.get_collider(c)
				if(enemy):
					damage_target(enemy)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass


func _on_death_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
