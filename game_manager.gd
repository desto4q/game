extends Node

@onready var label = %Label

var points = 0;
func add_points():
	points += 1
	label.text = "POINTS:" + str(points)
	print(points)
