extends Button
@onready var transition = $AnimationPlayer
func _on_pressed():
	transition.play("fade_out")
	

	
var height := 5.0
var bilis := 3.0
var orgposition := Vector2.ZERO
var time := 0.0

func _ready():
	orgposition = position
	set_process_input(true)

func _process(delta):
	time += delta
	var offset_y = sin(time * bilis) * height
	position.y = orgposition.y + offset_y
	
