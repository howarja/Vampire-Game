extends Node2D

@export var text: RichTextLabel;


func _ready() -> void:
	var vampiresAlive: int = Globals.vampiresLetIn-Globals.vampiresKilled;
	
	text.text = "[center]
	
	
	The night is over:
	
	Humans let in: "+str(Globals.humansLetIn)+"
	
	Vampires let in: "+str(Globals.vampiresLetIn)+"
	
	Humans Killed: "+str(Globals.humansKilled)+"

	Vampires Killed: "+str(Globals.vampiresKilled)+"
	
	Vampires Alive: "+str(vampiresAlive);
	
	if vampiresAlive > 0:
		text.text += "\n\n the host was killed and eaten by vampires. You failed.";
	else:
		text.text += "\n\n the host survived! You win!";
