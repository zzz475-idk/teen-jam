extends CanvasLayer


@onready var label: Label = $Label;
@onready var animation_player: AnimationPlayer = $AnimationPlayer;


func _ready() -> void:
	MusicPlayer.stop();
	
	await(get_tree().create_timer(7).timeout);
	label.text = "ever wondered about...";
	animation_player.play("ending")
	await(get_tree().create_timer(5).timeout)
	label.text = "about video game characters haveing familys too?";
	animation_player.play("ending");
	await(get_tree().create_timer(6.5).timeout);
	label.text = "i sent him back to his family.";
	animation_player.play("ending");
	await(get_tree().create_timer(6).timeout);
	label.text = "his name was Niko.";
	animation_player.play("ending");
	await(get_tree().create_timer(6).timeout);
	label.text = "poor little guy...";
	animation_player.play("ending")
	await(get_tree().create_timer(4.5).timeout);
	label.text = "and his mother...";
	animation_player.play("ending");
	await(get_tree().create_timer(4).timeout);
	label.text = "she was searching for him everywhere."
	animation_player.play("ending");
	await(get_tree().create_timer(5).timeout);
	label.text = "i gave you control over him.";
	animation_player.play("ending");
	await(get_tree().create_timer(6).timeout);
	label.text = "but i couldn't see him suffer anymore.";
	animation_player.play("ending");
	await(get_tree().create_timer(6).timeout);
	label.text = "if he would have died then...";
	animation_player.play("ending");
	await(get_tree().create_timer(8).timeout);
	label.text = "he would have died in the real world too!";
	animation_player.play("ending");
	await(get_tree().create_timer(6).timeout);
	label.text = "i hoped that...";
	animation_player.play("ending");
	await(get_tree().create_timer(4).timeout);
	label.text = "he could made me win a game jam.";
	animation_player.play("ending");
	await(get_tree().create_timer(7).timeout);
	label.text = "i'm sorry!";
	animation_player.play("ending");
