extends Node3D

var enemy = load("res://assets/enemy.tscn")
var enemies = []
var maxEnemies = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enemy_spawner_timeout() -> void:
	if len(enemies) < maxEnemies:
		var e = enemy.instantiate()
		
		var spawn_pos = get_node("Player/Marker3D/Camera3D/Bounds/SpawnPath/SpawnPos")
		spawn_pos.progress_ratio = randf()
		add_child(e)
		enemies.append(e)
		e.position = spawn_pos.position
	else:	
		pass # Replace with function body.
