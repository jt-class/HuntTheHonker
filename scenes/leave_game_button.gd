extends Button

@onready var confirmation_dialog = get_parent().get_node("ConfirmationDialog")  # Adjust the path as necessary


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect the pressed signal to the function
	self.pressed.connect(_on_pressed)
	confirmation_dialog.confirmed.connect(_on_confirmation_confirmed)

func _on_pressed() -> void:
	confirmation_dialog.popup_centered()  # Show the confirmation dialog

# This function is called when the user confirms the action
func _on_confirmation_confirmed() -> void:
	get_tree().quit()  # Close the game
