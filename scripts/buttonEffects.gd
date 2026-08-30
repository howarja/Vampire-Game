extends Button
class_name buttonEffects

var hovering=false
var shaking=false

func _ready() -> void:
	button_down.connect(_on_button_down);
	button_up.connect(_on_button_up);
	mouse_entered.connect(_on_mouse_entered);
	mouse_exited.connect(_on_mouse_exited);

func _physics_process(delta: float) -> void:
	if(hovering):
		if(!shaking):
			shaking=true
			var tween = get_tree().create_tween().set_parallel(true)
			tween.tween_property($".", "rotation", deg_to_rad(3), 0.15).set_trans(Tween.TRANS_QUAD)
			await tween.finished
			tween = get_tree().create_tween().set_parallel(true)
			tween.tween_property($".", "rotation", deg_to_rad(-3), 0.15).set_trans(Tween.TRANS_QUAD)
			await tween.finished
			shaking=false
			
			if(!hovering):
				$".".rotation = deg_to_rad(0)


func _on_button_down() -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($".", "scale", Vector2(1.1,1.1), 0.1).set_trans(Tween.TRANS_CUBIC)


func _on_button_up() -> void:
	if(hovering):
		var tween = get_tree().create_tween().set_parallel(true)
		tween.tween_property($".", "scale", Vector2(1.4,1.4), 0.1).set_trans(Tween.TRANS_CUBIC)
	else:
		var tween = get_tree().create_tween().set_parallel(true)
		tween.tween_property($".", "scale", Vector2(1.0,1.0), 0.1).set_trans(Tween.TRANS_CUBIC)


func _on_mouse_entered() -> void:
	hovering=true
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($".", "scale", Vector2(1.4,1.4), 0.1).set_trans(Tween.TRANS_CUBIC)


func _on_mouse_exited() -> void:
	hovering=false
	var tween = get_tree().create_tween().set_parallel(true)
	tween.tween_property($".", "scale", Vector2(1.0,1.0), 0.1).set_trans(Tween.TRANS_CUBIC)
