extends Sprite2D

# Reference to the AnimationPlayer node
@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	# Play the idle animation when the scene starts
	anim_player.play("idle")
