extends Control

@export var radius: float = 80.0  # raio do movimento máximo
var dragging = false
var direction: Vector2 = Vector2.ZERO

@onready var base = $Base
@onready var stick = $Base/Stick

func _ready():
	# Centraliza o stick na base
	stick.position = base.size / 2 - stick.size / 2

func _gui_input(event):
	# --- Toque (Android/iOS) ---
	if event is InputEventScreenTouch:
		if event.pressed:
			dragging = true
		else:
			dragging = false
			direction = Vector2.ZERO
			stick.position = base.size / 2 - stick.size / 2

	elif event is InputEventScreenDrag and dragging:
		_process_offset(event.position)

	# --- Mouse (PC/Web) ---
	elif event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
		elif not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = false
			direction = Vector2.ZERO
			stick.position = base.size / 2 - stick.size / 2

	elif event is InputEventMouseMotion and dragging:
		_process_offset(event.position)

# Função auxiliar para calcular direção e posição do stick
func _process_offset(pos: Vector2):
	var center = base.size / 2
	var offset = pos - center - $Base.position
	if offset.length() > radius:
		offset = offset.normalized() * radius
	stick.position = center + offset - stick.size / 2
	direction = offset / radius
