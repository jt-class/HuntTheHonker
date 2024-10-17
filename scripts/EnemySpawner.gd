extends Node2D

@onready var main = get_node(".")
var enemy_scene1 := preload("res://scenes/enemy_frog.tscn")
var enemy_scene2 := preload("res://scenes/enemy_snake.tscn")
var boss_scene2 := preload("res://scenes/boss_bird.tscn")


var spawn_points := []  # List of spawn points
var current_wave = 1
var active_enemies = []
var enemies_per_wave = {1: 5, 2: 10, 3: 1}
var enemies_spawned_in_wave = 0
var spawn_index = 0  # To track the current spawn point

func _ready() -> void:
	# Collect spawn points (in a predefined set order)
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)
	# Start the first wave
	spawn_wave()

# Wave spawning logic
func spawn_wave() -> void:
	enemies_spawned_in_wave = 0
	var enemies_to_spawn = enemies_per_wave.get(current_wave)
	for i in range(enemies_to_spawn):
		spawn_enemy()

# Spawn an enemy at the next predefined spawn point
func spawn_enemy() -> void:
	# Use the next spawn point in the set order
	var spawn = spawn_points[spawn_index]
	var enemy = null
	if current_wave == 1:
		enemy = enemy_scene1.instantiate()
	elif current_wave == 2:
		enemy = enemy_scene2.instantiate()
	elif current_wave ==3:
		enemy = boss_scene2.instantiate()
	enemy.position = spawn.position
	enemy.EnemySpawner = self  # Set EnemySpawner reference in enemy
	main.add_child(enemy)
	active_enemies.append(enemy)
	enemies_spawned_in_wave += 1

	# Move to the next spawn point in the list, looping back to the start
	spawn_index += 1
	if spawn_index >= spawn_points.size():
		spawn_index = 0  # Reset to the first spawn point if we've used all

# Called when an enemy is killed
func on_enemy_killed(enemy) -> void:
	active_enemies.erase(enemy)  # Remove enemy from active list
	if active_enemies.size() == 0 and enemies_spawned_in_wave == enemies_per_wave[current_wave]:
		if current_wave < 3:
			if current_wave == 1:
				print("wave 1 completed!")
			elif current_wave ==2:
				print("wave 2 completed!")
				
			current_wave += 1
			spawn_wave()
		else:
			print("All waves completed!")
