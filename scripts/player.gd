extends CharacterBody2D


@onready var animation: AnimatedSprite2D = $animation;
@onready var jump_buffer_timer: Timer = $"jump buffer timer";
@export var speed: float = 8000;
@export var jump_power: float = 9000;
@export var falling_speed: float = 500;
var can_move: bool = true;
var can_jump: bool = true;

func _ready() -> void:
	can_move = false;
	await(get_tree().create_timer(2.25).timeout);
	can_move = true;

func _physics_process(delta: float) -> void:
	movement(delta);
	animateing();
	falling(delta);
	jumping(delta);
	
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
		if (jump_buffer_timer.is_stopped()):
			jump_buffer_timer.start();
	else:
		can_jump = true;
		
func jumping(delta: float) -> void:
	if (Input.is_action_just_pressed("ui_up")):
		if (can_jump == true):
			velocity.y = (-jump_power) * delta;


func _on_jump_buffer_timer_timeout() -> void:
	can_jump = false;
