extends Node3D

@export var mag_size: int = 150
@export var starting_mag_ammo: int = 150
@export var starting_reserve_ammo: int = 50
@export var max_reserve: int = 150

@onready var ui: UI = $"../../../../UI"

var current_ammo: int
var reserve_ammo: int
