extends Button

@export var newArea: Area;
@export var movementSFX: AudioStreamMP3;

func _ready() -> void:
	pressed.connect(move);

func move():
	Globals.player.fadeTo(newArea);
	Globals.player.playMovement(movementSFX);
