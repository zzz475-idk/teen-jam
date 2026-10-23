extends CharacterBody2D


@onready var animation: AnimatedSprite2D = $animation;
@export var speed: float = 8000;
@export var falling_speed: float = 500;
var can_move: bool = true;

func _physics_process(delta: float) -> void:
	movement(delta);
	animateing();
	falling(delta);
	
func movement(delta: float) -> void:
	move_and_slide();
	
	if (can_move == true):
		if (Input.is_action_pressed("ui_left")):
			velocity.x = (-speed) * delta;
		elif (Input.is_action_pressed("ui_right")):
			velocity.x = speed * delta;
		else:
			velocity.x = 0;

func animateing() -> void:
	
	if (velocity.x > 0):
		animation.play("walk");
		animation.flip_h = false;
	if (velocity.x < 0):
		animation.play("walk");
		animation.flip_h = true;
	
	if (velocity == Vector2.ZERO):
		animation.play("idle");

func falling(delta: float) -> void:
	if !(is_on_floor()):
		velocity.y += falling_speed * delta;
