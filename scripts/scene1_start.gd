extends Node2D

@onready var transition = $AnimationPlayer
var scene1 = preload("res://scenes/home_screen.tscn")

func _on_taptostart_pressed() -> void:
	transition.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_packed(scene1)
