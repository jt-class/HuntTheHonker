extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null
var attack_value = 12   #attack value for this enemy


var health = 150
var player_inattack_zone = false
var can_take_damage = true

@onready var animationPlayer = $AnimatedSprite2D

# Reference to the EnemySpawner that spawned this enemy
var EnemySpawner = null

func enemy():
	pass
	
func _physics_process(delta):
	
	deal_with_damage()
	update_health()
	
	if player_chase:
		animationPlayer.play("walk")
		position += (player.position - position)/speed
		
		if(player.position.x - position.x) < 0:
			animationPlayer.flip_h = false
		else:
			animationPlayer.flip_h = true
			
	else:
		animationPlayer.play("idle")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

# When the player enters the enemy's attack zone (hitbox)
func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):  # Ensure it's the player
		player_inattack_zone = true

# When the player exits the enemy's attack zone (hitbox)
func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):  # Ensure it's the player
		player_inattack_zone = false

# Handle damage when in attack zone
func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		# Check if damage hasn't been dealt yet
		if can_take_damage == true and player.damage_dealt == false:
			health -= 20  # Reduce enemy health
			$take_damage_cooldown.start()  # Start damage cooldown
			can_take_damage = false
			player.damage_dealt = true  # Mark damage as dealt for this attack
			print("Enemy took damage, health:", health)
			if health <= 0:
				die()

# Handle enemy death
func die():
	if EnemySpawner:
		EnemySpawner.on_enemy_killed(self)  # Notify the spawner that this enemy has died
	self.queue_free()  # Remove enemy from the scene

# Reset the ability to take damage after cooldown
func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true
	
func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health
	
	if health >= 150:
		healthbar.visible = false
	else:
		healthbar.visible = true
