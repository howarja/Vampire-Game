extends Node2D
class_name playerManager;

@export var currentArea: Area;
@export var hallway: Area;
@export var fade: Panel;

@export var houseMusic: AudioStreamPlayer2D;
@export var outsideMusic: AudioStreamPlayer2D;

func _ready() -> void:
	Globals.player = self;
	fadeHouseMusic();

func changeAreaTo(newArea: Node2D) -> void:
	if currentArea!=null:
		currentArea.exitArea();
	currentArea = newArea;
	currentArea.enterArea();

func returnToHallway() -> void:
	fadeTo(hallway);

func fadeTo(newArea: Node2D) -> void:
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

func fadeHouseMusic() -> void:
	var fadeOut = create_tween();
	var fadeIn = create_tween();
	fadeOut.tween_property(houseMusic, "volume_db", 0, 0.5);
	fadeIn.tween_property(outsideMusic, "volume_db", -80, 2);
	
func fadeOutsideMusic() -> void:
	var fadeOut = create_tween();
	var fadeIn = create_tween();
	fadeOut.tween_property(houseMusic, "volume_db", -80, 2);
	fadeIn.tween_property(outsideMusic, "volume_db", 0, 0.1);

func fadeHouseMusicOutIn(length: int) -> void:
	var fadeoutTween = create_tween();
	fadeoutTween.tween_property(houseMusic, "volume_db", -80, 2);
	await get_tree().create_timer(length+1).timeout;
	var fadeInTween = create_tween();
	fadeInTween.tween_property(houseMusic, "volume_db", 0, 1);
