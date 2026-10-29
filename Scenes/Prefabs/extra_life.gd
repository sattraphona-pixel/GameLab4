extends Area2D
## ไอเท็มหัวใจ: เพิ่มชีวิต 1 ดวง

@export var amplitude := 5
@export var frequency := 3

var time_passed = 0.0
var initial_position := Vector2.ZERO

func _ready():
	initial_position = position

func _process(delta):
	time_passed += delta
	position.y = initial_position.y + amplitude * sin(frequency * time_passed)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		GameManager.add_life()
		AudioManager.coin_pickup_sfx.play()
		queue_free()
