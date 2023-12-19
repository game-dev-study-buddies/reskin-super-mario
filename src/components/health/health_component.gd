extends Node2D


@export var MAX_HEALTH := 10
var health: float


func _ready():
	health = MAX_HEALTH


func damage(attack: Attack):
	health -= attack.damage_value

	if health <= 0:
	# update this to a signal emission
	# the parent can choose what to do
		get_parent().queue_free()
