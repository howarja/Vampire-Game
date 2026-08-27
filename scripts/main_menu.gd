extends Node2D

@onready var normalText = $TextHolder/normalText

func _ready() -> void:
	$TextHolder/gameText.visible=false
	$Settings.visible = false
	$exitButton.visible=false
	normalText.modulate.a = 0
	fadeText("GAME PRODUCED BY",2.5)
	await get_tree().create_timer(5).timeout
	fadeText("James Howard\nJoshua Wolf\nTishar Sreekantam\nTijmen Verstappen\nDr. Zachavious XII Quinn the 2nd. Sr",3)
	await get_tree().create_timer(6).timeout
	logoAnimation()

func fadeText(newText,visibleLength):
	normalText.text = newText
	var tween = get_tree().create_tween()
	tween.tween_property(normalText, "modulate:a", 1, visibleLength).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	
	normalText.text = newText
	tween = get_tree().create_tween()
	tween.tween_property(normalText, "modulate:a", 0, visibleLength).set_trans(Tween.TRANS_CUBIC)
	await tween.finished

func logoAnimation():
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($TextHolder/topText, "position", Vector2(0,-240), 4).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($TextHolder/topText, "rotation", deg_to_rad(2520), 4).set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property($TextHolder/bottomText, "position", Vector2(0,240), 4).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($TextHolder/bottomText, "rotation", deg_to_rad(-2520), 4).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	
	tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($TextHolder/topText, "position", Vector2(0,-60), 0.2).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($TextHolder/bottomText, "position", Vector2(0,60), 0.2).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	
	$TextHolder/topText.visible=false
	$TextHolder/bottomText.visible=false
	
	$TextHolder/gameText.visible=true
	$exitButton.visible=true
	$Settings.visible = true


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://startScene.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
