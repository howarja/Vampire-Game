extends Node2D

@onready var normal_text = $TextHolder/normalText
@onready var top_text = $TextHolder/topText
@onready var bottom_text = $TextHolder/bottomText
@onready var game_text = $TextHolder/gameText

@onready var settings = $Settings
@onready var exit_button = $exitButton

func _ready() -> void:
	game_text.visible=false
	settings.visible = false
	exit_button.visible=false
	normal_text.modulate.a = 0
	fadeText("GAME PRODUCED BY",2.5)
	await get_tree().create_timer(5).timeout
	fadeText("James Howard\nJoshua Wolf\nTishar Sreekantam\nTijmen Verstappen\nDr. Zachavious XII Quinn the 2nd. Sr",3)
	await get_tree().create_timer(6).timeout
	logoAnimation()

func fadeText(newText,visibleLength):
	normal_text.text = newText
	var tween = get_tree().create_tween()
	tween.tween_property(normal_text, "modulate:a", 1, visibleLength).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	
	normal_text.text = newText
	tween = get_tree().create_tween()
	tween.tween_property(normal_text, "modulate:a", 0, visibleLength).set_trans(Tween.TRANS_CUBIC)
	await tween.finished

func logoAnimation():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(top_text, "position", Vector2(0,-240), 4).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(top_text, "rotation", deg_to_rad(2520), 4).set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property(bottom_text, "position", Vector2(0,240), 4).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(bottom_text, "rotation", deg_to_rad(-2520), 4).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	
	tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property(top_text, "position", Vector2(0,-60), 0.2).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(bottom_text, "position", Vector2(0,60), 0.2).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	
	top_text.visible=false
	bottom_text.visible=false
	
	game_text.visible=true
	exit_button.visible=true
	settings.visible = true


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/startScene.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
