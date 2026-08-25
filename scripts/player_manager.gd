extends Node2D

@export var currentArea: Node2D;

func changeAreaTo(newArea: Node2D):
	if currentArea!=null:
		currentArea.visible = false;
		currentArea = newArea;
	newArea.visible = true;
