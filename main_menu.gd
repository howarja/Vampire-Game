extends Node2D


@onready var normalText = $normalText
@onready var text2 = $RichTextLabel2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	normalText.modulate.a = 0
	text2.modulate.a = 0
	fadeText("GAME PRODUCED BY",2.5)
	await get_tree().create_timer(5).timeout
	fadeText("James Howard\nJoshua Wolf\nTishar Sreekantam\nTijmen Verstappen\nZach Quinn",3)
	await get_tree().create_timer(6).timeout


func fadeText(newText,visibleLength):
	normalText.text = newText
	var tween = get_tree().create_tween()
	tween.tween_property(normalText, "modulate:a", 1, visibleLength).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	
	normalText.text = newText
	tween = get_tree().create_tween()
	tween.tween_property(normalText, "modulate:a", 0, visibleLength).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
