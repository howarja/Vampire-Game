extends Node2D
class_name playerManager;

@export var currentArea: Area;
@export var hallway: Area;
@export var fade: Panel;

func _ready() -> void:
	Globals.player = self;

func changeAreaTo(newArea: Node2D):
	if currentArea!=null:
		currentArea.exitArea();
	currentArea = newArea;
	currentArea.enterArea();

func returnToHallway() -> void:
	changeAreaTo(hallway);

func fadeTo(newArea: Node2D):
	# fade darkness in, load new area, fade darkness out
	currentArea.disableMovement();
	var tween1 = create_tween();
	var dark: Color = Color(0.0, 0.0, 0.0, 1.0);
	tween1.tween_property(fade, "modulate", dark, 0.5);
	
	await get_tree().create_timer(1).timeout
	changeAreaTo(newArea)
	
	var opaque: Color = Color(0.0, 0.0, 0.0, 0.0);
	var tween2 = create_tween();
	tween2.tween_property(fade, "modulate", opaque, 0.5);
