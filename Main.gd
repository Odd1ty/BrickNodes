extends Control

# Template Node Declarations
var sgn = load("res://Nodes/SampleNode.tscn")
var initial_position = Vector2(40,40)
var node_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# On node add button pressed
func _on_Button_pressed():
	var node = sgn.instance()
	node.offset += initial_position + (node_index * Vector2(20,20))
	node.title += '-' + str(node_index)
	$GraphEdit.add_child(node)
	node_index += 1


# Whisker node connection
func _on_GraphEdit_connection_request(from, from_slot, to, to_slot):
	$GraphEdit.connect_node(from, from_slot, to, to_slot)

# Whisker node disconnection
func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	$GraphEdit.disconnect_node(from, from_slot, to, to_slot)

# Convert to js, currently just adds the value of each node.
func _on_Convert_pressed():
	var G = $GraphEdit
	var connection_list = G.get_connection_list()
	print(G.get_connection_list())
	var result = 0
	for i in range(0, connection_list.size()):
		var value = G.get_node(connection_list[i].from).get_node('SpinBox').value
		var value_2 = G.get_node(connection_list[i].to).get_node('SpinBox').value
		result += value
		if i+1 == connection_list.size():
			result += value_2
	print(result)

# On theme button pressed, which.. doesnt exist yet.
#func _on_Theme_pressed():
#	$Popup/FileDialog.visible = true
