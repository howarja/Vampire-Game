extends Button

@export var newArea: Node2D;

func _ready() -> void:
	pressed.connect(move);

func move():
	Globals.player.changeAreaTo(newArea);
