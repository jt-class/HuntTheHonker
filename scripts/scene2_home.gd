extends Control

@onready var transition = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fade_in")
