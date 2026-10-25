extends Label

@onready var timer: Timer = $Timer;



func _physics_process(delta: float) -> void:
	var m = int(GlobalVariables.total_time / 60.0);
	var s = GlobalVariables.total_time - m * 60;
	self.text = '%01d:%02d' % [m, s];

func _on_timer_timeout() -> void:
	GlobalVariables.total_time += 1;
