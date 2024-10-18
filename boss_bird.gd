extends CharacterBody2D

var speed = 120
var player_chase = false
var player = null
var attack_value = 15   # Attack value for this enemy
var show_hitbox = false
@onready var hitbox = $enemy_hitbox/CollisionShape2D

var health = 150
var player_inattack_zone = false
var still_inattack_zone = false
var can_take_damage = true
var is_attacking = false  # Track if the enemy is attacking

@onready var animationPlayer = $AnimatedSprite2D

# Reference to the EnemySpawner that spawned this enemy
var EnemySpawner = null

# Timer to control attack frequency
@onready var attack_timer = $attack_timer  # Add a Timer node in your scene
@onready var attack_indicator_timer = $attack_indicator_timer  # Use existing timer for attack indication

func enemy():
	pass
	
func _ready():
	attack_timer.wait_time = 2.0  # Set the attack interval to 2 seconds
	attack_indicator_timer.wait_time = 1.0  # Set the indicator timer to 1 second

func _physics_process(delta):
	if not is_attacking:  # Only move if not attacking
		deal_with_damage()
		update_health()

		if player_chase:
			animationPlayer.play("walk")

			# Normalize the direction vector to maintain constant speed
			var direction = (player.position - position).normalized()
			position += direction * speed * delta  # Multiply by delta for frame-rate independence
			
			# Flip sprite based on movement direction
			if direction.x < 0:
				animationPlayer.flip_h = false
			else:
				animationPlayer.flip_h = true
		else:
			animationPlayer.play("idle")

# Player enters detection area, start chasing
func _on_detection_area_body_entered(body):
	if body.has_method("player"):  # Ensure it's the player
		player = body
		player_chase = true  # Start chasing the player

# Player exits detection area, stop chasing
func _on_detection_area_body_exited(body):
	if body.has_method("player"):  # Ensure it's the player
		player = null
		player_chase = false  # Stop chasing if the player leaves the detection area

# When the player enters the enemy's attack zone (hitbox)
func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):  # Ensure it's the player
		$AttackRangeDrawer.set_hitbox_visible(true)  # Show the attack range
		player_inattack_zone = true
		still_inattack_zone = true
		attack_indicator_timer.start()  # Start the attack indicator timer

# When the player exits the enemy's attack zone (hitbox)
func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):  # Ensure it's the player
		$AttackRangeDrawer.set_hitbox_visible(false)  # Hide the attack range
		still_inattack_zone = false

# Attack timer logic
func _on_attack_indicator_timer_timeout() -> void:
	if player_inattack_zone:  # Ensure the player is still in the attack zone
		is_attacking = true  # Prevent movement while attacking
		print("Enemy attacks!")
		speed = 0  # Stop movement during attack
		animationPlayer.play("attack")  # Play the attack animation
		if player and still_inattack_zone and not player.is_defending == true:
			player.health -= attack_value # Apply damage to the player during the attack
			print("Player took damage! Player's health:", player.health)
		else:
			player_inattack_zone = false
		$chase_reset_timer.start(1)  # Start the reset timer to resume after the attack
	else:
		player_inattack_zone = false

# Reset movement after attack ends
func _on_chase_reset_timer_timeout() -> void:
	speed = 100  # Reset speed after the attack
	is_attacking = false  # Allow movement again
	$AttackRangeDrawer.set_hitbox_visible(false)  # Hide the hitbox after attacking

	if player and not player_inattack_zone:  # Resume chasing if the player is still in detection range but not in the attack zone
		player_chase = true  # Resume chasing
	else:
		player_chase = false  # Stop chasing if the player has left

func deal_with_damage():
	# Handle taking damage from player attacks
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
