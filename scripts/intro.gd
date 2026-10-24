extends CanvasLayer

@onready var label: Label = $Label;
@onready var animation_player: AnimationPlayer = $AnimationPlayer;
@onready var sound: AudioStreamPlayer2D = $sound;

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	await(get_tree().create_timer(5).timeout);
	label.text = "this wasn't a part of the plan!";
	animation_player.play("intro")
	await(get_tree().create_timer(3).timeout);
	Transition.transition(Transition.MAP_1);
