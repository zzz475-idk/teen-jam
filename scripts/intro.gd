extends CanvasLayer

@onready var label: Label = $Label;
@onready var animation_player: AnimationPlayer = $AnimationPlayer;
@onready var sound: AudioStreamPlayer2D = $sound;

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN);
	await(get_tree().create_timer(5).timeout);
	label.text = "guide the little guy!";
	animation_player.play("intro")
	await(get_tree().create_timer(2.5).timeout);
	Transition.transition(Transition.MAIN_MENU);
