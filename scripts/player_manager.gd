extends Node2D
class_name playerManager;

@export var currentArea: Area;
@export var hallway: Area;

func _ready() -> void:
	Globals.player = self;

func changeAreaTo(newArea: Node2D):
	if currentArea!=null:
		currentArea.exitArea();
	currentArea = newArea;
	currentArea.enterArea();

func returnToHallway() -> void:
	changeAreaTo(hallway);
