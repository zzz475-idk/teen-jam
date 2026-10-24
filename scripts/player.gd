extends CharacterBody2D


@onready var animation: AnimatedSprite2D = $animation;
@onready var jump_buffer_timer: Timer = $"jump buffer timer";
@onready var animation_player: AnimationPlayer = $AnimationPlayer;
@onready var ray_cast_2d: RayCast2D = $RayCast2D;
@onready var camera_2d: Camera2D = $Camera2D;
@onready var hp_amount: Label = $"ui/hearth/hp amount";
@export var speed: float = 8000;
@export var jump_power: float = 9000;
@export var falling_speed: float = 400;
var can_move: bool = true;
var can_jump: bool = true;
var dead: bool = false;

func _ready() -> void:
	can_move = false;
	await(get_tree().create_timer(2).timeout);
	can_move = true;

func _physics_process(delta: float) -> void:
	movement(delta);
	animateing();
	falling(delta);
	jumping(delta);
	
	hp_amount.text = str(GlobalVariables.hp) + 'x';
	
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
	
	if (dead == false):
		if (velocity.x > 0):
			animation.play("walk");
			animation.flip_h = false;
		if (velocity.x < 0):
			animation.play("walk");
			animation.flip_h = true;
		
		if (velocity == Vector2.ZERO):
			animation.play("idle");
	else:
		animation.play("death");

func falling(delta: float) -> void:
	if !(is_on_floor()):
		velocity.y += falling_speed * delta;
		if (jump_buffer_timer.is_stopped()):
			jump_buffer_timer.start();
	else:
		can_jump = true;
		
func jumping(delta: float) -> void:
	
	#variable jumping
	if (Input.is_action_just_released("ui_up") && velocity.y < 0):
		velocity.y = -10 * delta
	
	#non lineral jumping
	if (velocity.y > 0):
		falling_speed = 450;
	else:
		falling_speed = 400;
	
	#jump earilier
	if (ray_cast_2d.is_colliding()):
		can_jump = true;
	
	if (Input.is_action_just_pressed("ui_up")):
		if (can_jump == true):
			velocity.y = (-jump_power) * delta;
			animation_player.play("jump");

func death() -> void:
	if (dead == false):
		dead = true;
		
		var tween: Tween = create_tween();
		tween.set_ease(Tween.EASE_IN_OUT);
		tween.set_trans(Tween.TRANS_BACK);
		
		var tween2: Tween = create_tween();
		tween2.set_ease(Tween.EASE_IN_OUT);
		tween2.set_trans(Tween.TRANS_BACK);
		
		tween.tween_property(self, "position", Vector2(position.x ,position.y + 75), 2);
		tween2.tween_property(animation, "rotation_degrees", 1028, 2);
		
		
		await(get_tree().create_timer(0.5).timeout);
		camera_2d.process_mode = Node.PROCESS_MODE_DISABLED;
		await(get_tree().create_timer(0.5).timeout);
		Transition.reload();
		await(get_tree().create_timer(0.65).timeout);
		GlobalVariables.hp -= 1;

func camera_juice(zoom_x: float, zoom_y: float, time: float) -> void:
	var tween: Tween = create_tween();
	tween.set_trans(Tween.TRANS_CIRC);
	tween.set_ease(Tween.EASE_IN);
	
	
	tween.tween_property(camera_2d, "zoom", Vector2(zoom_x, zoom_y), time / 3);
	
	await(get_tree().create_timer(time / 3).timeout);
	
	var tween2: Tween = create_tween();
	tween2.set_trans(Tween.TRANS_CIRC);
	tween2.set_ease(Tween.EASE_IN);
	
	tween2.tween_property(camera_2d, "zoom", Vector2(1, 1), time / 3);
	

func _on_jump_buffer_timer_timeout() -> void:
	can_jump = false;
