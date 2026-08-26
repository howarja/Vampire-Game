extends Node2D
class_name playerManager;

@export var currentArea: Area;

func _ready() -> void:
	Globals.player = self;

func changeAreaTo(newArea: Node2D):
	if currentArea!=null:
		currentArea.visible = false;
		currentArea = newArea;
	newArea.visible = true;
