extends CharacterBody2D

var speed = 75
var player_chase = false
var player = null
var attack_value = 8   # Attack value for this enemy
var health = 60
var player_inattack_zone = false
var can_take_damage = true
var is_attacking = false  # Track if the enemy is attacking

@onready var animationPlayer = $AnimatedSprite2D

# Reference to the EnemySpawner that spawned this enemy
var EnemySpawner = null

# Timer to control attack frequency
@onready var attack_timer = $attack_timer  # Add a Timer node in your scene with a wait time of 1 second

func _ready():
	attack_timer.wait_time = 1.0  # Set attack interval

func _physics_process(delta):
	if not is_attacking:  # Only move if not attacking
		deal_with_damage()
		update_health()

		if player_chase:
			animationPlayer.play("walk")
			position += (player.position - position) / speed
			
			if (player.position.x - position.x) < 0:
				animationPlayer.flip_h = false
			else:
				animationPlayer.flip_h = true
		else:
			animationPlayer.play("idle")

# Player enters detection area, start chasing
func _on_detection_area_body_entered(body):
	if body.has_method("player"):  # Ensure it's the player
		player = body
		print("player spotted")
		player_chase = true

# Player exits detection area, stop chasing
func _on_detection_area_body_exited(body):
	if body.has_method("player"):  # Ensure it's the player
		print("player left")
		player = null
		player_chase = false

# When the player enters the enemy's attack zone (hitbox)
func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):  # Ensure it's the player
		player_inattack_zone = true
		attack_timer.start()  # Start attack timer when the player enters the attack zone

# When the player exits the enemy's attack zone (hitbox)
func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):  # Ensure it's the player
		player_inattack_zone = false
		attack_timer.stop()  # Stop attack timer when the player leaves the attack zone

# Attack timer logic
func _on_attack_timer_timeout() -> void:
	if player_inattack_zone:  # Ensure the player is still in the attack zone
		is_attacking = true  # Prevent movement while attacking
		animationPlayer.play("attack")  # Play attack animation
		print("Enemy attacks!")
		speed = 0  # Stop movement during attack
		$chase_reset_timer.start(0.5)  # Start reset timer to resume after attack
		# Apply damage to the player during the attack
		if player and not player.is_defending: 
			player.health -= attack_value
			print("Player took damage! Player's health:", player.health)

# Reset movement after attack ends
func _on_chase_reset_timer_timeout() -> void:
	speed = 75  # Reset speed after the attack
	is_attacking = false  # Allow movement again
	if player and not player_inattack_zone:  # Resume chasing if the player is still nearby
		player_chase = true
	else:
		player_chase = false

# Handle damage when in attack zone (taking damage from the player)
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
	
	if health >= 40:
		healthbar.visible = false
	else:
		healthbar.visible = true
func enemy():
	pass
