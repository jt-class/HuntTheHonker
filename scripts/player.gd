extends CharacterBody2D

@onready var joystick = $"../Control/ControlHud/JoyStick"
@onready var btn_Attack = $"../Control/ControlHud/AttackButton"
@onready var btn_Defend = $"../Control/ControlHud/DefendButton"
@onready var btn_Shoot = $"../Control/ControlHud/ShootButton"
var dash_key = KEY_SHIFT
var attack_key = KEY_SPACE
var speed = 300
const DASH_SPEED = 900.0
var can_dash = true

@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D  # Reference to Sprite2D node

var current_enemy = null
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

var damage_dealt = false  # Track if damage has been dealt during the attack
var is_attacking = false
var is_defending = false
var is_dashing = false
var death_animation_finished
var defend_animation_finished = false  # Track if the defend animation has finished

func _ready():
	# Connect button signals to the respective functions using Callables
	btn_Attack.connect("pressed", Callable(self, "_on_AttackButton_pressed"))
	btn_Defend.connect("pressed", Callable(self, "_on_DefendButton_pressed"))
	btn_Defend.connect("released", Callable(self, "_on_DefendButton_released"))
	btn_Shoot.connect("pressed", Callable(self, "_on_DashButton_pressed"))

	# Connect animation finished signal
	animationPlayer.connect("animation_finished", Callable(self, "_on_AnimationPlayer_animation_finished"))

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	update_health()
	
	# Check for keyboard dash input
	if Input.is_key_pressed(dash_key):
		_on_DashButton_pressed()  # Only call dash if it's not already dashing
		
	if Input.is_key_pressed(attack_key):
		_on_AttackButton_pressed()
	
	if health <= 0 and player_alive:
		player_alive = false
		health = 0
		print("Player has died!")
		self.queue_free()  # Remove player node from the scene after death

func player_movement(delta):
	var direction = joystick.posVector
	
	# Handle attack action
	if is_attacking:
		animationPlayer.play("Attack")
		$deal_attack_timer.start()
		return  # Prevents movement while attacking
	
	# Handle defend action
	if is_defending:
		if not defend_animation_finished:  # Only play if it's not already finished
			animationPlayer.play("Defend")
		return  # Prevents movement while defending
	
	# Handle dash action
	if is_dashing:
		velocity = direction * DASH_SPEED  # Increase speed for dash
		move_and_slide()
		animationPlayer.play("Shoot")
		return  # Prevents movement while dashing
	
	# Handle movement
	if direction:
		velocity = direction * speed
		if direction.x > 0:  # Moving right
			animationPlayer.play("Run")
			sprite.flip_h = false  # Ensure the sprite faces right
		elif direction.x < 0:  # Moving left
			animationPlayer.play("Run")
			sprite.flip_h = true  # Flip sprite horizontally to face left
	else:
		velocity = Vector2(0, 0)  # No movement, idle state
		animationPlayer.play("Idle")  # Use Idle animation

	move_and_slide()

# Function to handle attack button press
func _on_AttackButton_pressed():
	is_attacking = true
	animationPlayer.play("Attack")
	global.player_current_attack = true
	damage_dealt = false  # Reset this flag when starting an attack
	print(global.player_current_attack)

# Function to handle attack button release
func _on_AttackButton_released():
	is_attacking = false
	global.player_current_attack = false
	print(global.player_current_attack)
	

# Function to handle defend button press
func _on_DefendButton_pressed():
	is_defending = true
	defend_animation_finished = false  # Reset to allow animation to play
	animationPlayer.play("Defend")  # Start playing defend animation

# Function to handle defend button release
func _on_DefendButton_released():
	is_defending = false
	if defend_animation_finished:
		animationPlayer.stop()  # Stop only if the animation is finished

# Function to handle shoot button press
func _on_DashButton_pressed():
	if can_dash:
		is_dashing = true
		can_dash = false
		$dash_timer.start()
		$dash_cooldown.start()
		animationPlayer.play("Shoot")

# Reset actions when animations finish
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		is_attacking = false
		global.player_current_attack = false
		damage_dealt = false  # Reset this flag when the attack ends

	elif anim_name == "Defend":
		defend_animation_finished = true  # Mark the defend animation as finished

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = true
		current_enemy = body

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false
		current_enemy = null  # Clear the reference when out of range

# Ensure health only decreases when the enemy attacks
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown and !is_defending and current_enemy and current_enemy.is_attacking:
		enemy_attack_cooldown = false
		$attack_cooldown.start()  # Start cooldown for the next attack

func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true  # Allow another attack after cooldown

func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	global.player_current_attack = false
	is_attacking = false
	damage_dealt = false  # Ensure it's reset after attack cooldown

func _on_dash_timer_timeout() -> void:
	is_dashing = false

func _on_dash_cooldown_timeout() -> void:
	can_dash = true

func update_health():
	var healthbar = $Healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
func player():
	pass
