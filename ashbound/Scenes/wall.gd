extends CSGBox3D
var trees_burned=0
@onready var node_3d: Node3D = $"../../../Node3D"

func _ready() -> void:
	for node in node_3d.get_children():
		node.burn.connect(_on_tree_burned)
func _process(delta: float) -> void:
	if trees_burned>12:
		visible=false
		queue_free()
		
func _on_tree_burned():
	trees_burned+=1
	print(trees_burned)
