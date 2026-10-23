extends TileMapLayer


@onready var player: CharacterBody2D = $player;

func _physics_process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body == player):
		Transition.transition(Transition.MAP_2);
		await(get_tree().create_timer(0.1).timeout);
		player.can_move = false;
