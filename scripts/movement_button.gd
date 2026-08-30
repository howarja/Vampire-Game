extends Button

@export var newArea: Area;
@export var movementSFX: AudioStreamMP3;
@export var fadeLength: float = 1;

@onready var door = preload("res://Sprites/Buttons for moving3.png");
@onready var doorNoArrow = preload("res://Sprites/Buttons_for_moving3 (2).png");
@onready var doorOpen = preload("res://Sprites/Buttons for moving4.png");
@onready var doorOpenNoArrow = preload("res://Sprites/Buttons_for_moving4 (2).png");

@onready var eye = preload("res://Sprites/Buttons for moving2.png");
@onready var eyeOpen = preload("res://Sprites/Buttons for moving1.png");

@export var eyeSymbol: bool = false;
@export var doorArrow: bool = true;

func _ready() -> void:
	pressed.connect(move);
	mouse_entered.connect(hovered);
	mouse_exited.connect(dehovered);
	dehovered();
	flat = true;
	text = "";

func move():
	Globals.player.fadeTo(newArea, fadeLength);
	await get_tree().create_timer(0.5).timeout;
	Globals.player.playMovement(movementSFX);

func hovered():
	if self.eyeSymbol:
		icon = eyeOpen;
	elif !self.eyeSymbol:
		if doorArrow:
			icon = doorOpen;
		else:
			icon = doorOpenNoArrow;

func dehovered():
	if self.eyeSymbol:
		icon = eye;
	elif !self.eyeSymbol:
		if doorArrow:
			icon = door;
		else:
			icon = doorNoArrow;
