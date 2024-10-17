extends Control

@onready var transition = $AnimationPlayer
# Called when the nodea enters the scene tree for the first time.
func _ready() -> void:
	transition.play("fade_in")


func _on_level_select_nav_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Level_select_modified.tscn")


func _on_OptionNav_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Option.tscn")
