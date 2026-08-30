extends Control

@onready var normal_text = $TextHolder/normalText

@onready var settings = $Settings
@onready var playButton = $TextHolder/PlayButton;
@onready var exit_button = $exitButton2

func _ready() -> void:
	settings.hide();
	exit_button.hide();
	normal_text.modulate.a = 0;
	playButton.hide();
	fadeText("A GAME BY\n\nJames Howard\nJoshua Wolf\nTishar Sreekantam\nTijmen Verschueren\nZachary Quinn",3)
	await get_tree().create_timer(6).timeout;
	#playButton.show();
	#settings.show();
	$MenuAnim.play("Logo")
	var tween = get_tree().create_tween()
	tween.tween_property($TextHolder/Blood, "position", Vector2(500,0), 2).set_trans(Tween.TRANS_ELASTIC)
	await tween.finished
	

func fadeText(newText,visibleLength):
	normal_text.text = newText
	var tween = get_tree().create_tween()
	tween.tween_property(normal_text, "modulate:a", 1, visibleLength).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	
	normal_text.text = newText
	tween = get_tree().create_tween()
	tween.tween_property(normal_text, "modulate:a", 0, visibleLength).set_trans(Tween.TRANS_CUBIC)
	await tween.finished


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/startScene.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
