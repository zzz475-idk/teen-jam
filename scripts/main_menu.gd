extends CanvasLayer


@onready var star_1: Sprite2D = $star/star1;
@onready var star_2: Sprite2D = $star/star2;
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D;
var started: bool = false

func _ready() -> void:
	await(get_tree().create_timer(2).timeout);
	audio_stream_player_2d.play();

func _physics_process(delta: float) -> void:
	star_1.rotation_degrees += 2 * delta;
	star_2.rotation_degrees += 2 * delta;
	
	if (Input.is_action_just_pressed("x")):
		if (started == false):
			Transition.transition(Transition.MAP_1);
