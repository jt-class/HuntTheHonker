extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_button_pressed():
	var new_scene = preload("res://scenes/level_select.gd")
	get_tree().change_scene_to(new_scene) 
