extends Sprite2D

var speed = Vector2(100, 0)  

func _process(delta):
	position += speed * delta
	
	if position.x > get_viewport_rect().size.x:
		position.x = -texture.get_size().x
