extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if OS.has_feature("mobile"):
	var joystick = preload("res://Joystick.tscn").instantiate()
	add_child(joystick)
	joystick.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Fuja dos bichos!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	$Joystick.hide()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed():
	$StartButton.hide()
	$Joystick.show()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()

func mostra_pontos():
	$ScoreLabel.visible = true

func oculta_pontos():
	$ScoreLabel.visible = false
	
