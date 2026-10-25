extends CanvasLayer


@onready var star_1: Sprite2D = $star/star1;
@onready var star_2: Sprite2D = $star/star2;
@onready var star: Node2D = $star;
var started: bool = false;

func _ready() -> void:
	await(get_tree().create_timer(2).timeout);
	MusicPlayer.play();

func _physics_process(delta: float) -> void:
	rotate_star(delta);

	
	if (Input.is_action_just_pressed("x")):
		if (started == false):
			started = true;
			Transition.transition(Transition.MAP_1);

func rotate_star(delta: float) -> void:
	star_1.rotation_degrees += 6 * delta;
