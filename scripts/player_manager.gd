extends Node2D
class_name playerManager;

@export var currentArea: Node2D;

func _ready() -> void:
	Globals.player = self;

func changeAreaTo(newArea: Node2D):
	if currentArea!=null:
		currentArea.visible = false;
		currentArea = newArea;
	newArea.visible = true;
