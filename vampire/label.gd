extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Speed: " + str(get_parent().speed) + "\nBlood: " + str(get_parent().blood) + "\nDistance: " + str(get_parent().distance_traveled)
