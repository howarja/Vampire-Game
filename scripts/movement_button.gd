extends Button

@export var newArea: Area;
@export var movementSFX: AudioStreamMP3;
@export var fadeLength: float = 1;

func _ready() -> void:
	pressed.connect(move);

func move():
	Globals.player.fadeTo(newArea, fadeLength);
	await get_tree().create_timer(0.5).timeout;
	Globals.player.playMovement(movementSFX);
