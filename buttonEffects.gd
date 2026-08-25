extends Button

var hovering=false
var shaking=false

func _physics_process(delta: float) -> void:
	if(hovering):
		if(!shaking):
			shaking=true
			var tween = get_tree().create_tween().set_parallel(true)
			tween.tween_property($"..", "rotation", deg_to_rad(3), 0.15)
			await tween.finished
			tween = get_tree().create_tween().set_parallel(true)
			tween.tween_property($"..", "rotation", deg_to_rad(-3), 0.15)
			await tween.finished
			shaking=false
			
			if(!hovering):
				$"..".rotation = deg_to_rad(0)


func _on_button_down() -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($"..", "scale", Vector2(1.1,1.1), 0.1).set_trans(Tween.TRANS_CUBIC)


func _on_button_up() -> void:
	if(hovering):
		var tween = get_tree().create_tween().set_parallel(true)
		tween.tween_property($"..", "scale", Vector2(1.4,1.4), 0.1).set_trans(Tween.TRANS_CUBIC)
	else:
		var tween = get_tree().create_tween().set_parallel(true)
		tween.tween_property($"..", "scale", Vector2(1.0,1.0), 0.1).set_trans(Tween.TRANS_CUBIC)


func _on_mouse_entered() -> void:
	hovering=true
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($"..", "scale", Vector2(1.4,1.4), 0.1).set_trans(Tween.TRANS_CUBIC)


func _on_mouse_exited() -> void:
	hovering=false
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($"..", "scale", Vector2(1.0,1.0), 0.1).set_trans(Tween.TRANS_CUBIC)
