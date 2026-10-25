extends Area2D

@onready var player: CharacterBody2D = $"../player";
@onready var exit_blocker: Sprite2D = $ExitBlocker;
@export var blocked: bool = false;

func _physics_process(delta: float) -> void:
	if (blocked == true):
		exit_blocker.visible = true;
	else:
		exit_blocker.visible = false;

func _on_body_entered(body: Node2D) -> void:
	if (body == player):
		if (blocked == false):
			Transition.transition(Transition.MAP_6);
			await(get_tree().create_timer(0.1).timeout);
			player.can_move = false;
