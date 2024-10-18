extends Node2D  # Or Sprite2D if you use that

var show_hitbox = false  # Controls whether the hitbox is drawn

# This is called when you want to toggle hitbox visibility
func set_hitbox_visible(visible: bool):
	show_hitbox = visible
	queue_redraw()  # This will trigger the _draw() function

# This function draws the hitbox if show_hitbox is true
func _draw():
	if show_hitbox:
		var shape = get_node("../enemy_hitbox/CollisionShape2D").shape # Access the shape from the parent enemy
		if shape is CircleShape2D:
			var radius = shape.radius
			draw_circle(Vector2.ZERO, radius, Color(1, 0, 0, 0.5))  # Red hitbox circle
		elif shape is RectangleShape2D:
			var extents = shape.extents
			draw_rect(Rect2(Vector2(-extents.x, -extents.y), extents * 2), Color(0, 1, 0, 0.5))  # Green hitbox rectangle
