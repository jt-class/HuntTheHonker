extends CharacterBody2D

@onready var joystick = $"../Camera2D/ControlHud/JoyStick"
@onready var btn_Attack = $"../Camera2D/ControlHud/AttackButton"
@onready var btn_Defend = $"../Camera2D/ControlHud/DefendButton"
@onready var btn_Shoot = $"../Camera2D/ControlHud/ShootButton"
var speed = 300

@onready var animationPlayer = $AnimationPlayer
@onready var sprite = $Sprite2D  # Reference to Sprite2D node

var is_attacking = false
var is_defending = false
var is_shooting = false
var defend_animation_finished = false  # Track if the defend animation has finished

func _ready():
	# Connect button signals to the respective functions using Callables
	btn_Attack.connect("pressed", Callable(self, "_on_AttackButton_pressed"))
	btn_Defend.connect("pressed", Callable(self, "_on_DefendButton_pressed"))
	btn_Defend.connect("released", Callable(self, "_on_DefendButton_released"))
	btn_Shoot.connect("pressed", Callable(self, "_on_ShootButton_pressed"))

	# Connect  animation finished signal
	animationPlayer.connect("animation_finished", Callable(self, "_on_AnimationPlayer_animation_finished"))

func _physics_process(delta):
	var direction = joystick.posVector
	
	# Handle attack action
	if is_attacking:
		animationPlayer.play("Attack")
		return  # Prevents movement while attacking
	
	# Handle defend action
	if is_defending:
		if not defend_animation_finished:  # Only play if it's not already finished
			animationPlayer.play("Defend")
		return  # Prevents movement while defending
	
	# Handle shooting action
	if is_shooting:
		animationPlayer.play("Shoot")
	
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

# Function to handle attack button release
func _on_AttackButton_released():
	is_attacking = false

# Function to handle defend button press
func _on_DefendButton_pressed():
	is_defending = true
	defend_animation_finished = false  # Reset to allow  animation to play
	animationPlayer.play("Defend")  # Start playing defend animation

# Function to handle defend button release
func _on_DefendButton_released():
	is_defending = false
	animationPlayer.stop()  # Stop the defend animation when the button is released

# Function to handle shoot button press
func _on_ShootButton_pressed():
	is_shooting = true
	animationPlayer.play("Shoot")

# Function to handle shoot button release
func _on_ShootButton_released():
	is_shooting = false

# Reset actions when animations finish
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		is_attacking = false
	elif anim_name == "Shoot":
		is_shooting = false
	elif anim_name == "Defend":
		defend_animation_finished = true  # Mark the defend animation as finished
