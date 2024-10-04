extends Button

# This function is called when the button is pressed
func _on_Back_button_pressed():
	# Change to the tap_to_starts scene
	get_tree().change_scene_to_file("res://scenes/tap_to_start.tscn")  # Update the path if needed

# Connect this function to the Back button's "pressed" signal, but first check if it's already connected
func _ready():
	if not is_connected("pressed", Callable(self, "_on_Back_button_pressed")):
		connect("pressed", Callable(self, "_on_Back_button_pressed"))
