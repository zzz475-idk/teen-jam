extends Sprite2D


var already_pressed: bool = false;

signal pressed;


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "player"):
		if (already_pressed == false):
			already_pressed = true;
			pressed.emit();


func _on_pressed() -> void:
	var tween: Tween = create_tween();
	tween.set_trans(Tween.TRANS_ELASTIC);
	tween.set_ease(Tween.EASE_OUT_IN);
	tween.tween_property(self, "position", Vector2(self.position.x, self.position.y + 8), 0.75);
