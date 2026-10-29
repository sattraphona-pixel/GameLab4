extends Area2D
## ไอเท็มสายฟ้า: เพิ่มความเร็วในการเดินของผู้เล่นชั่วคราว

@export var boost : float = 1.5      # คูณความเร็ว
@export var duration : float = 6.0   # วินาที
@export var amplitude := 5
@export var frequency := 4

var time_passed = 0.0
var initial_position := Vector2.ZERO
var taken := false

func _ready():
	initial_position = position

func _process(delta):
	time_passed += delta
	position.y = initial_position.y + amplitude * sin(frequency * time_passed)

func _on_body_entered(body):
	if taken or not body.is_in_group("Player"):
		return
	taken = true
	AudioManager.coin_pickup_sfx.play()
	hide()
	set_deferred("monitoring", false)
	body.move_speed *= boost
	await get_tree().create_timer(duration).timeout
	if is_instance_valid(body):
		body.move_speed /= boost
	queue_free()
