extends Node2D

@onready var transition = $AnimationPlayer
var scene1 = preload("res://scenes/home_screen.tscn")

func _on_taptostart_pressed() -> void:
	transition.play("fade_out")


<<<<<<< HEAD
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
=======
func _on_animation_player_animation_finished(anim_name) -> void:
>>>>>>> c7d477646a20c6709207bf5d2cfbe6702c5e8bef
	get_tree().change_scene_to_packed(scene1)
