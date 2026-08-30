extends Node2D

@export var text: RichTextLabel;
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	var max_humans = 17
	var max_vampires = 6
	var humans_let_in = Globals.humansLetIn;
	var vampires_let_in = Globals.vampiresLetIn;
	var humans_killed = Globals.humansKilled;
	var vampires_killed = Globals.vampiresKilled;
	
	var vampiresAlive: int = vampires_let_in-vampires_killed;
	var humans_alive: int = humans_let_in-humans_killed;
	
	text.text = "[center]
	
	
	The night is over:
	
	Humans let in: "+str(humans_let_in)+"
	
	Vampires let in: "+str(vampires_let_in)+"
	
	Humans Killed: "+str(humans_killed)+"
	
	Vampires Killed: "+str(vampires_killed)+"
	
	Vampires Alive: "+str(vampiresAlive);
	
	if vampiresAlive > 0:
		text.text += "\n\n the host was killed and eaten by vampires. You failed.";
		if(humans_killed > 0 ):
			## killed a human and theres still vampires remaining
			text.text += "\n\n You got the wrong one";
			text.text += "\n\n Blind Ending!";
			return;
		else: if(vampiresAlive == 1):
			text.text += "\n\n You missed one!";
			text.text += "\n\n There Was One Left Ending!";
			return;
		else: if humans_let_in == 0:
			## only let vampires in
			text.text += "\n\n You have a type, and its for blood suckers.";
			text.text += "\n\n Hotel for blood";
			return;
	else:
		text.text += "\n\n the host survived! You win!";
		if(humans_alive == 0 && humans_killed == max_humans && vampires_killed == max_vampires):
			## Genocide ending
			text.text += "\n\n But at what cost?";
			text.text += "\n\n Genocide Ending!";
			return;
		else: if(humans_killed > 0):
			## let both humans and vampires in and killed atleast one of both
			text.text += "\n\n You Killed a human??? You Murder!!!";
			text.text += "\n\n Prison Ending!";
			return;
		else: if(humans_let_in > 0 && vampires_let_in > 0):
			text.text += "\n\n Thats some top tier detective work!";
			text.text += "\n\n Detective Ending!";
			return;
		else: if(vampires_let_in == 0):
			## only let humans in only ending(let only humans in your house)
			text.text += "\n\n You were very picky";
			text.text += "\n\n Racist Ending!";
			return;
		else: if(vampires_let_in > 0 && humans_let_in == 0):
			## Vamp trap ending(let only vampires in your house and then kill them)
			text.text += "\n\n You got them all trapped.";
			text.text += "\n\n Vampire Trap Ending!";
			return;
		else:
			## Refuse ending(let no one in your house)
			text.text += "\n\n Thats not very nice refusing all of your guests.";
			text.text += "\n\n Bad Host Ending!";
			pass
