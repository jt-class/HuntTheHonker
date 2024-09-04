extends TouchScreenButton

@onready var knob = $Knob
@onready var maxDist = shape.radius

var jStickCenter: Vector2 = texture_normal.get_size()/2
var touched: bool = false

func _ready():
	set_process(false)

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			set_process(true)
		elif not event.pressed:
			set_process(false)
			knob.position = jStickCenter

func _process(delta):
	knob.global_position = get_global_mouse_position()
	knob.position = jStickCenter + (knob.position - jStickCenter).limit_length(maxDist)

func get_JstickDir() -> Vector2:
	var dir = knob.position - jStickCenter
	return dir.normalized()	 
