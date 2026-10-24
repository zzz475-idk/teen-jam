extends AnimatedSprite2D


@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D;
@export var speed: float = 1;


func _physics_process(delta: float) -> void:
	path_follow_2d.progress_ratio += speed * delta;
