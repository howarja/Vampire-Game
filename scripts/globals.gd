extends Node

var player: playerManager;
var conversation: conversationManager;
var doorway: doorwayManager;
var characters: characterManager;
var ending: endingManager;
var actionTimer: int = 0;

func actionTaken() -> void:
	actionTimer -= 1;

func resetActionTimer(newTime: int) -> void:
	actionTimer = newTime;
