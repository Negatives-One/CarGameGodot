extends Area

export var id : int = 0
var mesh : MeshInstance

func _ready():
	mesh = get_child(0)
	
func _on_Checkpoint_body_entered(body : Node):
	if(body.name == "Car"):
		get_parent().emit_signal("onCheckPointEntered", id, body)

func _process(_delta : float) -> void:
	look_at(InGameUi.car.translation, Vector3.UP)
	rotation_degrees = Vector3(90, rad2deg(rotation.y - PI), 0)

func SetInitial() -> void:
	mesh.material_override.set_shader_param("CurrentColor", Color.red)
