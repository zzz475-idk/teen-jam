extends CanvasLayer

@onready var label: Label = $Label;
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	await(get_tree().create_timer(4).timeout);
	label.text = "protect the little";
	animation_player.play("intro")
	await(get_tree().create_timer(4).timeout);
	label.text = "get ready!";
	animation_player.play("intro")
	await(get_tree().create_timer(2).timeout);
	Transition.transition(Transition.MAIN_MENU);
